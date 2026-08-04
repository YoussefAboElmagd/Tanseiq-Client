# Tanseiq — تنسيق

Field-operations app for camp readiness, inspections and asset management during
the Hajj season (Mina / Arafat). Teams use it to record readings, file reports,
run surveys, track rented assets and monitor camp readiness from the field.

- **Package name:** `com.mdarj.tansiq` (Android) · `com.mdarj.tanseiq` (iOS)
- **Version:** see `version:` in [pubspec.yaml](pubspec.yaml)
- **Backend:** `https://api.sjctanseiq.com/` — see [api_constants.dart](lib/core/networking/api_constants.dart)
- **Language:** Arabic-first (`locale: ar`, RTL), Arabic + English ARB files

---

## Requirements

| Tool | Version |
| --- | --- |
| Flutter SDK | stable channel, Dart `>=3.7.0` |
| Android | `targetSdk 34`, compile/min SDK from the Flutter defaults |
| iOS | deployment target `15.0` |
| Xcode / CocoaPods | required for the iOS build only |

---

## Getting started

```bash
flutter pub get

# Generates Freezed/JSON/Retrofit sources (*.freezed.dart, *.g.dart)
dart run build_runner build --delete-conflicting-outputs

# Generates lib/generated/l10n.dart from lib/l10n/*.arb
dart run intl_utils:generate

flutter run -t lib/main.dart
```

Re-run `build_runner` after touching any model, `ApiResult`, or Retrofit API
service; re-run `intl_utils` after editing an `.arb` file.

### Local secrets — not in the repo

These files are git-ignored and must be supplied before an Android release build
or a Firebase-dependent run:

| File | Purpose |
| --- | --- |
| `android/key.properties` | Upload keystore credentials |
| `android/app/*.jks` | Upload keystore |
| `android/app/google-services.json` | Firebase (Android) |
| `ios/Runner/GoogleService-Info.plist` | Firebase (iOS) |

Ask the project owner for them — never commit them.

---

## Architecture

Feature-first layering. Every feature owns its full vertical slice:

```
lib/
├── main.dart                  # bootstrap: logging, ScreenUtil, cache, DI, Bloc observer
├── tanseiq.dart               # MaterialApp: locale, theme, initial route
├── firebase_options.dart
├── core/
│   ├── di/                    # GetIt registrations (setupGetIt)
│   ├── networking/            # Dio factory, ApiResult, error handler/model, endpoints
│   ├── routing/               # Routes constants + AppRouter.generateRoute
│   ├── theming/               # colors, styles, assets, theme()
│   ├── helpers/               # cache, extensions, location service, Hijri validation
│   └── widgets/               # shared UI: buttons, form fields, app bars, pickers, PDF viewer
├── features/<feature>/
│   ├── data/
│   │   ├── apis/              # Retrofit service
│   │   ├── models/            # Freezed + json_serializable
│   │   └── repos/             # returns ApiResult<T>
│   └── presentation/
│       ├── manager/           # Cubit + state
│       └── views/             # screens + widgets/
└── l10n/ · generated/         # ARB sources and generated localization
```

**Data flow:** `View → Cubit → Repo → Retrofit API → Dio`. The repo wraps every
call in `ApiResult<T>` (`Success` / `Failure`, [api_result.dart](lib/core/networking/api_result.dart)),
so failures travel as values instead of exceptions and the Cubit maps them to states.

**Dependency injection:** plain GetIt, wired manually in
[dependency_injection.dart](lib/core/di/dependency_injection.dart) — API service,
repo and Cubit registered per feature.

**Routing:** string constants in [routes.dart](lib/core/routing/routes.dart),
resolved by [app_router.dart](lib/core/routing/app_router.dart) via `onGenerateRoute`.

**Logging:** `live_log_care` only — `LiveLog.d/i/w/e(...)`. Output is
redaction-scrubbed (tokens, passwords, OTPs, PII) and silenced below `warning`
in release. `LiveLogBlocObserver` routes Bloc lifecycle events through the same
pipeline. Do not use `print()` or `debugPrint()`.

**Sizing:** `flutter_screenutil` against a 375×812 design — use `.w/.h/.r/.sp`
rather than raw pixel values.

---

## Features

| Feature | What it does |
| --- | --- |
| `auth` | Login, account recovery, OTP, new password |
| `base` | Bottom-nav shell and shared UI cubit |
| `home` | Dashboard and entry points |
| `camp` | Camp list, details, analysis, Mina readiness, prepare & all-work |
| `readiness_monitoring` · `readiness_license` | Readiness follow-up and licensing |
| `complains` | Report an issue, details, attachments, analysis |
| `surveys` | Create, answer and review field surveys |
| `hypothesis` · `electricity_hypotheses` | Water / electricity hypotheses |
| `recording_readings` · `arafat_electricity_reading` | Meter reading capture |
| `asset_rentail` | Rental requests, tracking, accept/reject |
| `map` | Google Maps points and picking |
| `support` · `notifications` · `team` · `drawer` | Support, alerts, team management, navigation |

---

## Conventions

- No hardcoded strings, colors or dimensions — use `l10n`, `core/theming` and ScreenUtil.
- No business logic in widgets; no `flutter/material` imports inside cubits or repos.
- Models are Freezed + `json_serializable` with explicit `@JsonKey`; nullable fields
  are expected since the API may omit keys.
- Prefer small `StatelessWidget`s over widget-returning functions.
- Cross-layer data moves as typed models, never `Map<String, dynamic>`.

---

## Permissions

`CAMERA`, `INTERNET`, `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` — used for
attachment capture, API access and field geotagging.

---

## Building

```bash
# Debug / profile
flutter run -t lib/main.dart
flutter run --release -t lib/main.dart

# Android
flutter build apk --release --split-per-abi
flutter build appbundle --release          # Play Store upload

# iOS
flutter build ipa --release
```

Release builds are signed from `android/key.properties`; without it the Gradle
release config fails.

---

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| `*.g.dart` / `*.freezed.dart` missing | `dart run build_runner build --delete-conflicting-outputs` |
| `S.of(context)` or `l10n.dart` missing | `dart run intl_utils:generate` |
| Stale generated output after a merge | `dart run build_runner clean` then rebuild |
| Android release build fails on signing | Restore `android/key.properties` and the `.jks` |
| Firebase init crash on launch | Add the missing `google-services.json` / `GoogleService-Info.plist` |
