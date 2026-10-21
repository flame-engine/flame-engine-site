// Easter egg: pressing the up arrow (or tapping on a touch screen) on the home
// page turns the little dino into a playable game, made with Flame and loaded
// in an iframe. See dino_game/README.md for the messages exchanged with it.
(function () {
  var demo = document.querySelector('.flame-demo[data-dino-src]');
  if (!demo) {
    return;
  }

  var CHANNEL = 'flame-dino';
  var LOAD_TIMEOUT_MS = 10000;

  var frame = null;
  var ready = false;
  var active = false;
  var loadTimer = null;

  function send(type) {
    frame.contentWindow.postMessage(
      { source: CHANNEL, type: type },
      window.location.origin
    );
  }

  function isTyping(target) {
    return (
      target instanceof HTMLElement &&
      (target.isContentEditable || /^(INPUT|TEXTAREA|SELECT)$/.test(target.tagName))
    );
  }

  function isDinoVisible() {
    var rect = demo.getBoundingClientRect();
    return rect.bottom > 0 && rect.top < window.innerHeight;
  }

  function show() {
    active = true;
    demo.classList.add('dino-active');
    send('start');
    frame.focus();
    frame.contentWindow.focus();
  }

  function hide() {
    active = false;
    demo.classList.remove('dino-active');
    if (frame) {
      frame.blur();
    }
    window.focus();
  }

  // Drops the game if it never loads, so that the static dino stays.
  function abandon() {
    hide();
    if (frame) {
      frame.remove();
    }
    frame = null;
    ready = false;
  }

  function open() {
    if (active) {
      frame.focus();
      frame.contentWindow.focus();
      return;
    }
    if (frame) {
      if (ready) {
        show();
      }
      return;
    }
    frame = document.createElement('iframe');
    frame.className = 'dino-frame';
    frame.setAttribute('aria-hidden', 'true');
    frame.setAttribute('tabindex', '-1');
    frame.setAttribute('allowtransparency', 'true');
    frame.title = 'Dino game';
    frame.src = demo.getAttribute('data-dino-src');
    demo.appendChild(frame);
    loadTimer = setTimeout(abandon, LOAD_TIMEOUT_MS);
  }

  window.addEventListener('message', function (event) {
    if (
      !frame ||
      event.origin !== window.location.origin ||
      event.source !== frame.contentWindow ||
      !event.data ||
      event.data.source !== CHANNEL
    ) {
      return;
    }
    if (event.data.type === 'ready') {
      clearTimeout(loadTimer);
      ready = true;
      show();
    } else if (event.data.type === 'closed') {
      hide();
    }
  });

  // While the game is shown, its keys must never scroll the page, even when the
  // focus is back in the page (the keys inside the iframe are handled by it).
  var GAME_KEYS = ['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight', ' '];

  document.addEventListener('keydown', function (event) {
    if (active && GAME_KEYS.indexOf(event.key) !== -1 && !isTyping(event.target)) {
      event.preventDefault();
      frame.focus();
      frame.contentWindow.focus();
      return;
    }
    if (
      event.key !== 'ArrowUp' ||
      event.repeat ||
      event.altKey ||
      event.ctrlKey ||
      event.metaKey ||
      event.shiftKey ||
      isTyping(event.target) ||
      !isDinoVisible()
    ) {
      return;
    }
    event.preventDefault();
    open();
  });

  // No up arrow on a touch screen: tapping the dino starts the game instead.
  demo.addEventListener('pointerdown', function (event) {
    if (event.pointerType === 'touch' && !active) {
      open();
    }
  });
})();
