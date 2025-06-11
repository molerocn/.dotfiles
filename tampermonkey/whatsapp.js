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
let buttons = null;
let chatDiv = null;
let isChangeSetup = false;
let isHideSetup = false;

// ocultar
let sidebarDiv = null;
let filtersDiv = null;
let searchDiv = null;
let brandDiv = null;

const navs = ['d', 'h', 't', 'n', 'm', 'w', 'v'];
let isVisible = true
let chatDivDefaultWidth = 0;
let sidebarDivDefaultWidth = 0;

// singleton
function setup_change_event() {
    if (divs === null) {
        divs = document.querySelectorAll('div');
    }
    if (chatDiv === null) {
        chatDiv = Array.from(divs).find(el =>
            el.getAttribute('aria-label') === 'Chat list');
    }
}

function setup_hide_event() {
    if (divs === null) {
        divs = document.querySelectorAll('div');
    }
    if (chatDiv === null) {
        chatDiv = Array.from(divs).find(el =>
            el.getAttribute('aria-label') === 'Chat list');
    }
    if (sidebarDiv === null) {
        sidebarDiv = chatDiv.parentElement.parentElement.parentElement.parentElement.parentElement;
    }
    if (filtersDiv === null) {
        filtersDiv = Array.from(divs).find(el =>
            el.getAttribute('aria-label') === 'chat-list-filters');
    }
    if (searchDiv === null) {
        searchDiv = Array.from(divs).find(el =>
            el.getAttribute('aria-label') === 'Search input textbox');
        searchDiv = searchDiv.parentElement.parentElement.parentElement.parentElement;
    }
    if (buttons === null) {
        buttons = document.querySelectorAll('button');
    }
    if (brandDiv === null) {
        brandDiv = Array.from(buttons).find(el =>
            el.getAttribute('aria-label') === 'Menu');
        brandDiv = brandDiv.parentElement.parentElement.parentElement.parentElement.parentElement;
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
        setup_hide_event();

        if (chatDivDefaultWidth === 0) {
            chatDivDefaultWidth = chatDiv.offsetWidth;
        }
        if (sidebarDivDefaultWidth === 0) {
            sidebarDivDefaultWidth = sidebarDiv.offsetWidth;
        }
        if (isVisible) {
            chatDiv.style.maxWidth = '94px';
            sidebarDiv.style.maxWidth = '96px'
            filtersDiv.style.display = 'none'
            searchDiv.style.display = 'none';
            brandDiv.style.display = 'none';
            isVisible = false;
        } else {
            chatDiv.style.maxWidth = `${chatDivDefaultWidth}px`;
            sidebarDiv.style.maxWidth = `${sidebarDivDefaultWidth}px`;
            filtersDiv.style.display = 'flex'
            searchDiv.style.display = 'block'
            brandDiv.style.display = 'flex'
            isVisible = true;
        }
    }

    // cambiar entre cada chat igual que en mi terminal
    for (let i = 0; i < navs.length; i++) {
        if (e.altKey && e.key === navs[i]) {
            e.preventDefault();
            setup_change_event();

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
