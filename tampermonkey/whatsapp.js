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

const navs = ['d', 'b', 'h', 't', 'n', 'm', 'w', 'v'];
let isVisible = true
let chatDivDefaultWidth = 0;
let sidebarDivDefaultWidth = 0;

// singleton
function setup_change_event() {
    divs = document.querySelectorAll('div');
    chatDiv = Array.from(divs).find(el =>
        el.getAttribute('aria-label') === 'Chat list');
    isChangeSetup = true
}

function setup_hide_event() {
    if (!isChangeSetup) {
        setup_change_event()
    }
    sidebarDiv = chatDiv.parentElement.parentElement.parentElement.parentElement.parentElement;
    filtersDiv = Array.from(divs).find(el =>
        el.getAttribute('aria-label') === 'chat-list-filters');
    searchDiv = Array.from(divs).find(el =>
        el.getAttribute('aria-label') === 'Search input textbox');
    searchDiv = searchDiv.parentElement.parentElement.parentElement.parentElement;
    buttons = document.querySelectorAll('button');
    brandDiv = Array.from(buttons).find(el =>
        el.getAttribute('aria-label') === 'Menu');
    brandDiv = brandDiv.parentElement.parentElement.parentElement.parentElement.parentElement;

    isHideSetup = true;
}

// navigation functions
function navigateToChat(idx) {
    if (!isChangeSetup) {
        setup_change_event();
    }

    if (chatDiv) {
        const chat = chatDiv.children[idx].children[0].children[0];
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
}

document.addEventListener('keydown', function(e) {
    // TODO: agregar evento para poder buscar dentro del chat

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

    if (e.altKey && e.key === 'r' && !e.ctrlKey) {
        e.preventDefault();
        // ocultar el div izquierdo
        if (!isHideSetup) {
            setup_hide_event();
        }

        if (chatDivDefaultWidth === 0) {
            chatDivDefaultWidth = chatDiv.offsetWidth;
        }
        if (sidebarDivDefaultWidth === 0) {
            sidebarDivDefaultWidth = sidebarDiv.offsetWidth;
        }
        if (isVisible) {
            showGreenFlag()
            chatDiv.style.maxWidth = '94px';
            sidebarDiv.style.maxWidth = '96px'
            filtersDiv.style.display = 'none'
            searchDiv.style.display = 'none';
            brandDiv.style.display = 'none';
            isVisible = false;
        } else {
            for (let i = 0; i < chatDiv.children.length; i++) {
                const chat = chatDiv.children[i]
                chat.style.backgroundColor = '';
            }
            chatDiv.style.maxWidth = `${chatDivDefaultWidth}px`;
            sidebarDiv.style.maxWidth = `${sidebarDivDefaultWidth}px`;
            filtersDiv.style.display = 'flex'
            searchDiv.style.display = 'block'
            brandDiv.style.display = 'flex'
            isVisible = true;
        }

        // mostrar un circulo izquierdo si cuenta con mensajes

    }
    function showGreenFlag() {
        if (!isChangeSetup) {
            setup_change_event();
        }

        for (let i = 0; i < chatDiv.children.length; i++) {
            const chat = chatDiv.children[i]
            // Solo spans que tengan aria-label (más eficiente)
            const spans = chat.querySelectorAll('span[aria-label]');

            // buscar la palabra "unread" como palabra completa (case-insensitive)
            const tieneUnread = Array.from(spans).some(span => {
                const label = span.getAttribute('aria-label');
                return typeof label === 'string' && /\bunread\b/i.test(label.trim());
            });

            if (tieneUnread) {
                chat.style.backgroundColor = 'green';
            } else {
                chat.style.backgroundColor = '';
            }
        }
    }

    // cambiar entre cada chat igual que en mi terminal
    // for (let i = 0; i < navs.length; i++) {
    //     // TODO: usar keycode en vez de letra KeyK en vez de k
    //     if (e.altKey && e.key === navs[i]) {
    //         e.preventDefault();
    //         navigateToChat(i);
    //         return;
    //     }
    // }
}, false);

