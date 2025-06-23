document.addEventListener('keydown', function(e) {

    // navigate chat backward
    if (e.ctrlKey && e.code === "KeyE") {
        // FIX: evento no funciona
        e.preventDefault();
        navigateWithDirection(0)
    }
    // navigate chat forward
    if (e.ctrlKey && e.code === "KeyR") {
        // FIX: evento no funciona
        e.preventDefault();
        navigateWithDirection(1)
    }


    if (e.ctrlKey && e.key === '/') {
        const customButtons = document.querySelectorAll('button');
        console.log(customButtons)
        searchButton = Array.from(customButtons).find(el =>
            el.getAttribute('aria-label') === 'Search...');
        console.log(searchButton);
        searchButton.click();
    }


})


// funciones
function navigateWithDirection(direction) {
    if (!isChangeSetup) {
        setup_change_event();
    }
    const chats = chatDiv.children;

    let currentPosition = null;
    chats.filter((chat, idx) => {
        if (chat.getAttribute("aria-selected") === true) {
            currentPosition = idx;
            return;
        }
    })
    let goTo = 0;
    if (currentPosition === null) {
        navigateToChat(goTo);
        return;
    }
    if (direction === 0 && currentPosition != 0) {
        goTo = currentPosition + 1;
    } else {
        goTo = currentPosition - 1;
    }
    navigateToChat(goTo);
}
