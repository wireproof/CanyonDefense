# Experimental touch-position patch

Canyon Defense uses Ruffle 0.7.1 (bundled JS commit 89a7049965f3090e706265670df309a5128233ac). In the 0.7.1 core input pipeline, AVM1 mouse handlers run before mouse position is updated from the incoming event. Desktop mouse motion generally provides an earlier position update; a new touchscreen contact need not. The game's toolbar buttons and cursor read _root._xmouse/_ymouse inside mouse handlers. This is a concrete candidate explanation for first-touch placement failure, not device proof.

This candidate passively watches trusted primary touch down and up events targeting the player canvas and dispatches a synthetic pointermove with identical coordinates before the original event reaches Ruffle. It leaves the original down/up untouched, does not process mouse, secondary touches, non-canvas controls, or synthetic inputs, and does not modify the SWF. The candidate index references touch-position.js ahead of ruffle.js. The source and mock event checks are isolated here; they are not included in the app or installed on a device.

Local check: `/Users/wireproof/.local/share/rea-suite/node-v24.21.0-darwin-arm64/bin/node Research/patches/touch-position/test.js`.

Before promotion test a first-touch toolbar-to-valid-cell drag, multiple placements, tap-to-select and tap-to-place, invalid drops, cancel, abilities, menu controls, and tower deselection. Check real iOS pointer and shadow-DOM behavior, and verify separately on the iPhone and iPad. A simulator slot is currently reserved for other work.
