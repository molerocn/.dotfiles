// ==UserScript==
// @name         Whatsapp actions
// @namespace    http://tampermonkey.net/
// @version      2025-05-25
// @description  try to take over the world!
// @author       You
// @match        https://web.whatsapp.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

let divs = null;
let chatDiv = null;
const navs = ['d', 'h', 't', 'n', 'm', 'w', 'v'];
let isVisible = true
let defaultWidth = 0;

function setup() {
    if (divs === null) {
        divs = document.querySelectorAll('div');
    }
    if (chatDiv === null) {
        chatDiv = Array.from(divs).find(el =>
            el.getAttribute('aria-label') === 'Chat list');
    }
}

document.addEventListener('keydown', function(e) {

    if (e.ctrlKey && e.key === 'f') {
        e.preventDefault();
        const altKEvent = new KeyboardEvent("keydown", {
            key: "k",
            code: "KeyK",
            altKey: true,
            bubbles: true
        });
        document.dispatchEvent(altKEvent)
        return;
    }

    if (e.altKey && e.key === 's') {
        e.preventDefault();
        setup();

        if (defaultWidth === 0) {
            defaultWidth = chatDiv.offsetWidth;
        }
        if (isVisible) {
            chatDiv.style.maxWidth = '95px';
            isVisible = false;
        } else {
            chatDiv.style.maxWidth = `${defaultWidth}px`;
            isVisible = true;
        }
    }

    for (let i = 0; i < navs.length; i++) {
        if (e.altKey && e.key === navs[i]) {
            e.preventDefault();
            setup();

            if (chatDiv) {
                const chat = chatDiv.children[i].children[0].children[0];
                chat.focus()

                const enterEvent = new KeyboardEvent('keydown', {
                    key: 'Enter',
                    code: 'Enter',
                    keyCode: 13,
                    which: 13,
                    bubbles: true,
                    cancelable: true
                });

                chat.dispatchEvent(enterEvent);
            }
            return;
        }
    }

}, false);
