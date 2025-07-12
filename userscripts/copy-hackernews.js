// ==UserScript==
// @name         Hacker News Comment Extractor
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Extract and copy comments from Hacker News threads
// @author       ChatGPT
// @match        https://news.ycombinator.com/item*
// @grant        GM_setClipboard
// ==/UserScript==

(function() {
    'use strict';

    // Create and add clipboard button
    const addClipboardButton = () => {
        const submissionRow = document.querySelector('tr.athing.submission');
        if (!submissionRow) return;

        const button = document.createElement('button');
        button.textContent = '📋 Copy Comments';
        button.style.marginLeft = '2px';
        button.style.cursor = 'pointer';
        button.title = 'Copy processed comments to clipboard';

        button.addEventListener('click', () => {
            const comments = Array.from(
                document.querySelectorAll('table.comment-tree .commtext.c00')
            ).map(div => div.textContent.trim())
              .filter(text => text.split(/\s+/).length >= 20)
              .map(text => text.replace(/\n+/g, '\n').trim());

            if (comments.length > 100) {
                comments.length = 100; // Limit to 100 comments
            }

            const finalText = `Summarize these comments by groups:\n\n${comments.join('\n\n')}`;
            GM_setClipboard(finalText);

            // Provide some feedback to the user
            button.textContent = '✅';
            setTimeout(() => { button.textContent = '📋'; }, 2000);
        });

        submissionRow.appendChild(button);
    };

    // Add button after page load
    window.addEventListener('load', addClipboardButton);
})();