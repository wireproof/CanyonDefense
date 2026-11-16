/* Experimental Ruffle touch position synchronization. */
(function () {
  'use strict';
  function synchronize(event) {
    if (!event.isTrusted || event.pointerType !== 'touch' || !event.isPrimary) return;
    const path = event.composedPath();
    const canvas = path.find(node => node && node.tagName === 'CANVAS');
    if (!canvas) return;
    // Flash reads the prior mouse position during AVM1 mouse handlers. Deliver
    // a move first so the ensuing real press/release sees this touch position.
    canvas.dispatchEvent(new PointerEvent('pointermove', {
      bubbles: true, composed: true, cancelable: true,
      pointerId: event.pointerId, pointerType: event.pointerType,
      isPrimary: true, clientX: event.clientX, clientY: event.clientY,
      screenX: event.screenX, screenY: event.screenY,
      button: -1, buttons: event.buttons, pressure: event.pressure
    }));
  }
  document.addEventListener('pointerdown', synchronize, {capture: true, passive: true});
  document.addEventListener('pointerup', synchronize, {capture: true, passive: true});
})();
