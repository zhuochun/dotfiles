// ==UserScript==
// @name         YouTube Transcript to Clipboard
// @namespace    http://tampermonkey.net/
// @version      1.4
// @description  Adds a button to copy the transcript, auto-opening the panel, grouping into paragraphs, and isolating lines starting with “>>”.
// @author       ChatGPT
// @match        https://www.youtube.com/*
// @grant        GM_setClipboard
// ==/UserScript==

(function() {
    'use strict';

    function waitForElement(selector, timeout = 10000) {
        return new Promise((resolve, reject) => {
            const start = Date.now();
            (function check() {
                const elem = document.querySelector(selector);
                if (elem) return resolve(elem);
                if (Date.now() - start >= timeout) return reject(new Error(`Element ${selector} not found in ${timeout}ms`));
                requestAnimationFrame(check);
            })();
        });
    }

    function openTranscriptPanel() {
        // Expand “more” menu
        const expandBtn = document.querySelector('tp-yt-paper-button#expand.button.style-scope.ytd-text-inline-expander');
        if (expandBtn) expandBtn.click();
        // Click “Show transcript” button
        const btnSelector = '#items button[aria-label="Show transcript"]';
        return waitForElement(btnSelector, 5000)
            .then(() => document.querySelector(btnSelector).click())
            .then(() => waitForElement(
                'ytd-engagement-panel-section-list-renderer[target-id="engagement-panel-searchable-transcript"]',
                50000
            ));
    }

    function createClipboardButton() {
        const btn = document.createElement('button');
        Object.assign(btn.style, {
            display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
            marginLeft: '8px', padding: '4px', border: 'none', borderRadius: '2px',
            cursor: 'pointer', background: 'transparent', color: 'var(--yt-spec-text-primary)'
        });
        btn.title = 'Copy transcript';
        btn.textContent = '📋';

        btn.addEventListener('click', async () => {
            try {
                await openTranscriptPanel();
                const panel = document.querySelector(
                    'ytd-engagement-panel-section-list-renderer[target-id="engagement-panel-searchable-transcript"]'
                );
                if (!panel) return alert('Transcript panel not available');

                const title = document.querySelector('h1.ytd-watch-metadata')?.textContent.trim() || 'Untitled';
                const raw = panel.querySelector('#segments-container')?.textContent || '';
                const lines = raw.split('\n').map(l => l.trim()).filter(Boolean);

                const tsRegex = /^\d{1,2}:\d{2}(?::\d{2})?$/;
                const entries = [];
                let current = null;
                for (const line of lines) {
                    if (tsRegex.test(line)) {
                        if (current) entries.push(current);
                        current = { ts: line, content: '' };
                    } else if (current) {
                        let text = line.replace(new RegExp(`\\b${current.ts}\\b`, 'g'), '').trim();
                        current.content = current.content ? `${current.content} ${text}` : text;
                    }
                }
                if (current) entries.push(current);

                const paras = [];
                let bufTs = '', bufText = '';
                const MAX = 300;
                const arrowPrefix = /^>>\s/;

                for (const { ts, content } of entries) {
                    if (arrowPrefix.test(content)) {
                        // flush buffer
                        if (bufText) paras.push(`${bufTs} ${bufText.trim()}`);
                        // isolated arrow line
                        paras.push(`${ts} ${content}`);
                        bufTs = '';
                        bufText = '';
                        continue;
                    }
                    if (!bufText) {
                        bufTs = ts;
                        bufText = content;
                        continue;
                    }
                    const trial = `${bufText} ${content}`;
                    if (trial.length <= MAX) {
                        bufText = trial;
                    } else {
                        const idx = Math.max(bufText.lastIndexOf('.'), bufText.lastIndexOf('。'));
                        if (idx > -1 && idx < bufText.length - 1) {
                            paras.push(`${bufTs} ${bufText.slice(0, idx+1).trim()}`);
                            const leftover = bufText.slice(idx+1).trim();
                            bufTs = ts;
                            bufText = leftover ? `${leftover} ${content}` : content;
                        } else {
                            paras.push(`${bufTs} ${bufText.trim()}`);
                            bufTs = ts;
                            bufText = content;
                        }
                    }
                }
                if (bufText) paras.push(`${bufTs} ${bufText.trim()}`);

                const output = `Title: ${title}\n\n${paras.join('\n\n')}`;
                GM_setClipboard(output);
                btn.textContent = '✅';
                setTimeout(() => btn.textContent = '📋', 2000);
            } catch (e) {
                console.error('Error copying transcript:', e);
            }
        });
        return btn;
    }

    waitForElement('#owner').then(owner => {
        if (!owner.querySelector('.clipboard-button')) {
            const btn = createClipboardButton();
            btn.classList.add('clipboard-button');
            owner.appendChild(btn);
        }
    }).catch(console.warn);
})();