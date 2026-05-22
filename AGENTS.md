# AGENTS.md

## Project
Flutter federated plugin (Melos monorepo) wrapping the Sourcepoint CMP SDKs for Android & iOS, plus optional WebView extensions. Uses FVM-pinned Flutter SDK at `.fvm/flutter_sdk`. Always invoke Dart/Flutter via `fvm` (e.g. `fvm flutter ...`, `fvm dart ...`).

## Packages (under `packages/`)
- `sourcepoint_unified_cmp` — app-facing plugin + `example/` app
- `sourcepoint_unified_cmp_platform_interface` — platform interface (Pigeon-generated messages)
- `sourcepoint_unified_cmp_android` (Kotlin) / `sourcepoint_unified_cmp_ios` (Swift) — native implementations
- `sourcepoint_unified_cmp_flutter_webview_extension`, `..._flutter_inappwebview_extension` — optional webview integrations (with example apps)

## Build / Test / Lint
- Bootstrap: `melos bootstrap` (after `./setup_environment.sh` for a clean env)
- Analyze: `melos run analyze` · Format everything: `melos run format:all` (needs `swiftformat`, `ktlint`)
- All tests + coverage + cspell: `melos run test:all` · Per-package tests: `melos run test`
- Single test: `cd packages/<pkg> && fvm flutter test test/path/to_foo_test.dart --plain-name "name"`
- Codegen: `melos run generate:pigeon:all`, `melos run generate:mocks:all`
- Run example app: `melos run run:example -- -d <device>` (variants: `run:example:flutter_webview`, `run:example:flutter_inappwebview`)
- Coverage gate: `melos run check-coverage` (≥20%, generated `*.g.dart` excluded)

## Style
- Dart lints: `very_good_analysis` 5.1.0 (strict; `example/` excluded). Follow effective-Dart naming: `lowerCamelCase` members, `UpperCamelCase` types, `snake_case` files. Prefer `final`/`const`, trailing commas, single-quoted strings, relative imports inside a package, package imports across packages. Never edit generated `*.g.dart` / Pigeon outputs by hand.
- Swift: `swiftformat .` (see `.swiftformat`). Kotlin: `ktlint --format` (skip `**/*.g.kt`).
- Errors: surface via Pigeon `FlutterError` from native; on Dart side use typed exceptions and `Result`-style returns where present—don’t swallow errors.
- Commit hygiene: keep changelogs per-package (Melos manages versioning); don’t hand-bump versions.

