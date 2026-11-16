# Canyon Defense

An experimental iOS compatibility build of the supplied Flash tower-defense game. The app uses Ruffle to run the game locally in a WebKit view and adapts its original controls for touch. It targets iPhone and iPad and retains the original game's artwork, audio, and rules where supported by Ruffle.

This is an early test build, not a finished remaster. Gameplay compatibility, touch controls, sound transitions, and the inside and cover layouts of iPhone Duo need further device testing. Live speed controls are not yet implemented. The iOS Home Screen label is Canyon TD; its bundle identifier is `com.wireproof.canyondefense`.

Version 0.3.5 build 8 adds an experimental touch-position adjustment intended to allow a single drag from the toolbar. Device gameplay and the fix remain unverified.

The `RuffleApp` directory contains the iOS wrapper and bundled web player. `Original` contains the supplied SWF, `Research` contains recovered assets and patches, and `Art` contains the custom icon. Ruffle's MIT and Apache license files accompany its runtime. The legacy native prototype is retained separately for reference.

## Building

Use XcodeGen to generate the project from `project.yml`, then build with Xcode for iOS. Device installation requires signing with a suitable development certificate and provisioning profile. A profile-free release IPA, when supplied, must be signed for the target device before installation.
