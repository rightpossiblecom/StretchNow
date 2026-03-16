# StretchNow Production Checklist

Purpose: Final pre-release verification for Google Play Store production.
Date: March 16, 2026

## Pre-Release Information

| Field | Value |
|-------|-------|
| App Name | StretchNow |
| Package Name | com.stretchnow.app |
| Primary Color | #8B5CF6 |
| Website URL | https://stretchnow.app |
| Support Email | support@stretchnow.app |
| Privacy Policy URL | https://stretchnow.app/privacy-policy |

## Phase 1: Branding and Visuals

- [x] Device Preview configured in app (enabled only outside release mode).
- [x] App icon source present at assets/app_logo.png.
- [x] flutter_launcher_icons configured in pubspec.yaml.
- [x] flutter_native_splash configured in pubspec.yaml.
- [x] Android app name set to StretchNow in AndroidManifest.xml.

## Phase 2: Android Release Signing

- [x] Release keystore generated: docs/release/stretchnow-release.jks.
- [x] Android key.properties configured with release alias and passwords.
- [x] Keystore copied to android/app/stretchnow-release.jks.
- [x] build.gradle.kts uses release signing config for release builds.
- [x] Keystore backup exists in docs/release.
- [x] Backup key.properties exists in docs/release.
- [x] Release credentials summary exists in docs/release/README.md.
- [x] gitignore updated to exclude key.properties and .jks files.

## Phase 3: Permissions Audit

- [x] AndroidManifest reviewed.
- [x] INTERNET permission present.
- [x] No unnecessary dangerous permissions found in main manifest.

## Phase 4: Version and Build Number

- [x] pubspec.yaml version set: 1.0.0+1.
- [ ] Bump to next release version before final upload if this build was already distributed.

## Phase 5: App Store Metadata

- [x] Play Store listing file exists at docs/release/play_store_listing.txt.
- [x] Privacy policy file exists at docs/release/privacy_policy.md.
- [ ] Verify hosted privacy policy page is publicly accessible at https://stretchnow.app/privacy-policy.
- [ ] Add phone screenshots to docs/release/screenshots/ (minimum 2).
- [ ] Add optional tablet screenshots if targeting tablets.
- [ ] Add feature graphic file at docs/release/featured_graphic_stretchnow.png.
- [ ] Complete category and content rating in Play Console.

## Phase 6: Technical Verification

- [ ] Build debug APK: flutter build apk --debug.
- [ ] Build release AAB: flutter build appbundle --release.
- [ ] Install and test release build on a real device.
- [ ] Verify notifications, schedule, history, settings, and offline behavior.
- [ ] Verify R8 shrinking does not break JSON or Hive storage.

## Phase 7: Deployment

- [ ] Upload AAB to Internal Testing track in Play Console.
- [ ] Test with at least 5 devices/accounts.
- [ ] Resolve all pre-launch report issues.
- [ ] Promote tested release to Production.

## Phase 8: Handoff Package

- [ ] Create encrypted archive from docs/release for secure handoff.
- [ ] Transfer archive password through a separate secure channel.

## Blocking Issues Resolved

- [x] Removed debug-sign fallback from Android release build.
- [x] Restored strict release signing path required by Play Console.

## Final Go/No-Go

Current status: Not ready for immediate production submission until Phase 5-7 unchecked items are completed and release AAB is validated on-device.
