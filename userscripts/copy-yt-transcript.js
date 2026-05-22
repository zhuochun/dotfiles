// ==UserScript==
// @name         YouTube Transcript to Clipboard
// @namespace    http://tampermonkey.net/
// @version      1.5
// @description  Adds a button to copy the transcript, auto-opening the panel, grouping into paragraphs, and supporting old/new YouTube transcript DOMs.
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

    function waitForCondition(condition, timeout = 10000, label = 'condition') {
        return new Promise((resolve, reject) => {
            const start = Date.now();
            (function check() {
                const result = condition();
                if (result) return resolve(result);
                if (Date.now() - start >= timeout) return reject(new Error(`${label} not found in ${timeout}ms`));
                requestAnimationFrame(check);
            })();
        });
    }

    function findTranscriptPanel() {
        const knownPanel = document.querySelector(
            'ytd-engagement-panel-section-list-renderer[target-id="engagement-panel-searchable-transcript"]'
        );
        if (knownPanel) return knownPanel;

        return Array.from(document.querySelectorAll('ytd-engagement-panel-section-list-renderer'))
            .find(panel => panel.querySelector('#segments-container, transcript-segment-view-model'));
    }

    function waitForTranscriptPanel(timeout = 50000) {
        return waitForCondition(findTranscriptPanel, timeout, 'Transcript panel');
    }

    function openTranscriptPanel() {
        const existingPanel = findTranscriptPanel();
        if (existingPanel) return Promise.resolve(existingPanel);

        // Expand “more” menu
        const expandBtn = document.querySelector('tp-yt-paper-button#expand.button.style-scope.ytd-text-inline-expander');
        if (expandBtn) expandBtn.click();
        // Click “Show transcript” button
        const btnSelector = '#items button[aria-label="Show transcript"], button[aria-label="Show transcript"]';
        return waitForElement(btnSelector, 5000)
            .then(btn => btn.click())
            .then(() => waitForTranscriptPanel(50000));
    }

    function parseStructuredTranscript(panel) {
        const segments = Array.from(panel.querySelectorAll('transcript-segment-view-model'));
        if (!segments.length) return [];

        return segments.map(segment => {
            const ts = segment.querySelector('.ytwTranscriptSegmentViewModelTimestamp')?.textContent.trim() || '';
            const textNode = segment.querySelector('[role="text"].ytAttributedStringHost, .ytAttributedStringHost[role="text"], .ytAttributedStringHost');
            const content = textNode?.textContent.trim() || '';
            return { ts, content };
        }).filter(({ ts, content }) => ts && content);
    }

    function parseLegacyTranscript(panel) {
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
        return entries;
    }

    function getTranscriptEntries(panel) {
        return parseStructuredTranscript(panel).length
            ? parseStructuredTranscript(panel)
            : parseLegacyTranscript(panel);
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
                const panel = await openTranscriptPanel();
                if (!panel) return alert('Transcript panel not available');

                const title = document.querySelector('h1.ytd-watch-metadata')?.textContent.trim() || 'Untitled';
                const entries = getTranscriptEntries(panel);
                if (!entries.length) return alert('Transcript segments not available');

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