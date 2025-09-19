// ==UserScript==
// @name         Chatgpt actions
// @namespace    http://tampermonkey.net/
// @version      2025-05-25
// @description  Enfocar chat y escribir la letra solo una vez (sin capturar Ctrl/Alt/Shift/Meta)
// @author       molerocn
// @match        https://chatgpt.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

document.addEventListener('keydown', function(e) {
    const tag = document.activeElement.tagName.toLowerCase();
    const isEditable = document.activeElement.isContentEditable;
    if (tag === "input" || tag === "textarea" || isEditable) return;

    if (e.ctrlKey && e.key === 'b') {
        e.preventDefault();
        document.querySelector('button[aria-label="Close sidebar"]').click();
        return;
    }

    if (e.ctrlKey && e.key === 'u') {
        e.preventDefault();
        document.querySelector('button[aria-label="Open sidebar"]').click();
        return;
    }

    // Ignorar si se usan modificadores
    if (e.ctrlKey || e.altKey || e.metaKey) return;

    if (/^[a-zA-Z]$/.test(e.key)) {
        const chatInput = document.querySelector('[contenteditable="true"]');

        if (chatInput) {
            e.preventDefault();

            chatInput.focus();
            document.execCommand("insertText", false, e.key);
        }
    }
});

