// ==UserScript==
// @name         Chatgpt actions
// @namespace    http://tampermonkey.net/
// @version      2025-05-25
// @description  try to take over the world!
// @author       You
// @match        https://chatgpt.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

let buttonCloseSidebar = null;
let chats = null;
const navs = ['h', 't', 'n', 'm', 'w', 'v'];

document.addEventListener('keydown', function(e) {

    if (e.ctrlKey && e.key === 'f') {
        e.preventDefault();
        const altKEvent = new KeyboardEvent("keydown", {
            key: "k",
            code: "KeyK",
            altKey: true,
            ctrlKey: true,
            bubbles: true
        });
        document.dispatchEvent(altKEvent)
        return;
    }

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

    for (let i = 0; i < navs.length; i++) {
        if (e.altKey && e.key === navs[i]) {
            e.preventDefault();
            if (chats === null) {
                const history = document.getElementById("history");
                chats = history.querySelectorAll("a");
            }

            chats[i].click();
        }
    }
});
