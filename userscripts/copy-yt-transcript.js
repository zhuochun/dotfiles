// ==UserScript==
// @name         YouTube Transcript to Clipboard
// @namespace    http://tampermonkey.net/
// @version      1.3
// @description  Adds a button to copy the transcript to the clipboard.
// @author       You
// @match        https://www.youtube.com/*
// @grant        GM_setClipboard
// ==/UserScript==

(function() {
    'use strict';

    // A helper function to wait for an element to appear in the DOM.
    function waitForElement(selector, timeout = 10000) {
        return new Promise((resolve, reject) => {
            const start = Date.now();

            (function check() {
                const element = document.querySelector(selector);
                if (element) {
                    resolve(element);
                } else if (Date.now() - start >= timeout) {
                    reject(new Error(`Element ${selector} not found within ${timeout}ms`));
                } else {
                    requestAnimationFrame(check);
                }
            })();
        });
    }

    // Create the clipboard button
    function createClipboardButton() {
        const btn = document.createElement('button');
        btn.style.display = 'inline-flex';
        btn.style.alignItems = 'center';
        btn.style.justifyContent = 'center';
        btn.style.marginLeft = '8px';
        btn.style.padding = '4px';
        btn.style.border = 'none';
        btn.style.borderRadius = '2px';
        btn.style.cursor = 'pointer';
        btn.style.background = 'transparent';
        btn.style.color = 'var(--yt-spec-text-primary)';
        btn.title = 'Copy transcript';

        // Adding a clipboard icon (using an emoji for simplicity)
        btn.textContent = '📋';

        btn.addEventListener('click', async () => {
            try {
                const transcriptPanel = document.querySelector('ytd-engagement-panel-section-list-renderer[target-id="engagement-panel-searchable-transcript"]');
                if (!transcriptPanel) {
                    alert("Transcript panel not found!");
                    return;
                }

                // Extract title
                const titleElement = document.querySelector('h1.ytd-watch-metadata');
                const title = titleElement ? titleElement.textContent.trim() : 'Untitled';

                // Extract text from the transcript panel
                let text = transcriptPanel.querySelector('#segments-container')?.textContent || '';

                // Split by newline, trim lines, remove empty lines
                const lines = text
                    .split('\n')
                    .map(line => line.trim())
                    .filter(line => line !== '');

                // Combine lines based on timestamps
                const timestampRegex = /^\d{1,2}:\d{2}(?::\d{2})?$/;
                const combinedLines = [];
                let currentEntry = '';

                for (const line of lines) {
                    if (timestampRegex.test(line)) {
                        if (currentEntry) {
                            combinedLines.push(currentEntry.trim());
                        }
                        currentEntry = line; // Start a new entry with the timestamp
                    } else {
                        currentEntry += ` ${line}`; // Append line to the current entry
                    }
                }

                if (currentEntry) {
                    combinedLines.push(currentEntry.trim());
                }

                const finalText = `Title: ${title}\nTranscript:\n${combinedLines.join('\n')}`;

                GM_setClipboard(finalText);

                // Provide some feedback to the user
                btn.textContent = '✅';
                setTimeout(() => { btn.textContent = '📋'; }, 2000);
            } catch (err) {
                console.error("Failed to copy text: ", err);
            }
        });

        return btn;
    }

    // Wait for the owner container and add the clipboard button
    waitForElement('#owner').then(ownerContainer => {
        // Ensure we only add one button if the script re-runs
        if (!ownerContainer.querySelector('.clipboard-button')) {
            const clipboardButton = createClipboardButton();
            clipboardButton.classList.add('clipboard-button');
            ownerContainer.appendChild(clipboardButton);
        }
    }).catch((error) => {
        console.warn(error);
    });

})();