// ==UserScript==
// @name         YouTube Transcript to Clipboard
// @namespace    http://tampermonkey.net/
// @version      1.6
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

        const transcriptNode = document.querySelector(
            '#segments-container, ytd-transcript-segment-renderer, transcript-segment-view-model'
        );
        return transcriptNode?.closest('ytd-engagement-panel-section-list-renderer') || null;
    }

    function waitForTranscriptPanel(timeout = 50000) {
        return waitForCondition(findTranscriptPanel, timeout, 'Transcript panel');
    }

    function parseStructuredTranscript(root) {
        const segments = Array.from(root.querySelectorAll('transcript-segment-view-model'));
        if (!segments.length) return [];

        return segments.map(segment => {
            const ts = segment.querySelector('.ytwTranscriptSegmentViewModelTimestamp')?.textContent.trim() || '';
            const textNode = segment.querySelector('[role="text"].ytAttributedStringHost, .ytAttributedStringHost[role="text"], span[role="text"], .ytAttributedStringHost');
            const content = textNode?.textContent.trim() || '';
            return { ts, content };
        }).filter(({ ts, content }) => ts && content);
    }

    function parseLegacyTranscriptFromNodes(root) {
        const segments = Array.from(root.querySelectorAll('ytd-transcript-segment-renderer'));
        if (!segments.length) return [];

        return segments.map(segment => {
            const ts = segment.querySelector('.segment-timestamp, #timestamp')?.textContent.trim() || '';
            const content = segment.querySelector('.segment-text, #segment-text')?.textContent.trim() || '';
            return { ts, content };
        }).filter(({ ts, content }) => ts && content);
    }

    function parseLegacyTranscriptFromText(root) {
        const raw = root.querySelector('#segments-container')?.textContent || '';
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

    function parseLegacyTranscript(root) {
        const entriesFromNodes = parseLegacyTranscriptFromNodes(root);
        return entriesFromNodes.length ? entriesFromNodes : parseLegacyTranscriptFromText(root);
    }

    function getTranscriptEntries(root = document) {
        const structuredEntries = parseStructuredTranscript(root);
        return structuredEntries.length ? structuredEntries : parseLegacyTranscript(root);
    }

    function waitForTranscriptEntries(panel, timeout = 10000) {
        return waitForCondition(() => {
            const panelEntries = panel ? getTranscriptEntries(panel) : [];
            if (panelEntries.length) return panelEntries;

            const documentEntries = getTranscriptEntries(document);
            return documentEntries.length ? documentEntries : null;
        }, timeout, 'Transcript segments');
    }

    function openTranscriptPanel() {
        const existingPanel = findTranscriptPanel();
        if (existingPanel && getTranscriptEntries(existingPanel).length) return Promise.resolve(existingPanel);

        // Expand “more” menu
        const expandBtn = document.querySelector('tp-yt-paper-button#expand.button.style-scope.ytd-text-inline-expander');
        if (expandBtn) expandBtn.click();
        // Click “Show transcript” button
        const btnSelector = '#items button[aria-label="Show transcript"], button[aria-label="Show transcript"]';
        const btn = document.querySelector(btnSelector);
        if (btn) {
            btn.click();
            return waitForTranscriptPanel(50000);
        }

        if (existingPanel) return Promise.resolve(existingPanel);

        return waitForElement(btnSelector, 5000)
            .then(showTranscriptBtn => showTranscriptBtn.click())
            .then(() => waitForTranscriptPanel(50000));
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
                const entries = await waitForTranscriptEntries(panel);

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