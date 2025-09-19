// ==UserScript==
// @name         Gemini input focus helper
// @namespace    http://tampermonkey.net/
// @version      2025-08-31
// @description  Enfocar rich-textarea automáticamente y escribir la tecla presionada
// @author       molerocn
// @match        https://gemini.google.com/*
// @grant        none
// ==/UserScript==

function getMainEditor() {
    let principal = null;
    let maxArea = 0;

    document.querySelectorAll('rich-textarea').forEach(el => {
        const rect = el.getBoundingClientRect();
        const area = rect.width * rect.height;
        if (area > maxArea) {
            maxArea = area;
            principal = el;
        }
    });

    if (!principal) return null;
    return principal.querySelector('.ql-editor');
}

function clickWithCoords(el) {
    const rect = el.getBoundingClientRect();
    const x = rect.left + rect.width / 2;
    const y = rect.top + rect.height / 2;

    ["mousedown", "mouseup", "click"].forEach(type => {
        el.dispatchEvent(new MouseEvent(type, {
            bubbles: true,
            cancelable: true,
            view: window,
            clientX: x,
            clientY: y
        }));
    });
}

document.addEventListener('keydown', e => {
    console.log("pressing");

    const editor = getMainEditor();
    console.log(editor);

    if (!editor) return;
    if (document.activeElement === editor) return;
    if (e.ctrlKey || e.altKey || e.metaKey) return;

    e.preventDefault();

    // Simular click y focus
    clickWithCoords(editor);
    editor.focus();

    // Insertar la primera tecla
    const text = e.key;
    const selection = window.getSelection();
    const range = document.createRange();

    range.selectNodeContents(editor);
    range.collapse(false); // mover al final
    selection.removeAllRanges();
    selection.addRange(range);

    console.log(text)
    document.execCommand("insertText", false, text);
});
