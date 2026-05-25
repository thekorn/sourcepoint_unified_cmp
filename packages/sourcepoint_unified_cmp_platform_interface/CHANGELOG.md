## 1.0.1

 - **FIX**: restore platform instance in tearDown to prevent test leakage. ([1d9e9831](https://github.com/thekorn/sourcepoint_unified_cmp/commit/1d9e98319dfa4c3d8349ad52c30d1c8b6c7448e6))
 - **FIX**: resolve analyzer warnings in test files. ([9c99d4c0](https://github.com/thekorn/sourcepoint_unified_cmp/commit/9c99d4c0cc1333b96b0079c1fed45a45e2d7e8a4))
 - **FIX**(ios): handle unsupported campaign types gracefully instead of crashing. ([9d581c89](https://github.com/thekorn/sourcepoint_unified_cmp/commit/9d581c89498de837afa02e125a2bfb6371684775))
 - **FEAT**: implement all missing campaign types (usnat/ios14/globalcmp/preferences). ([51e69f9c](https://github.com/thekorn/sourcepoint_unified_cmp/commit/51e69f9c833357ba2d16945398e3935c88122a0e))
 - **FEAT**: Implement custom consent methods for GDPR. ([027309f1](https://github.com/thekorn/sourcepoint_unified_cmp/commit/027309f1462ec5a3439ed9d734b5faa2c11a835f))
 - **FEAT**(consent): add customConsentGdpr / deleteCustomConsentGdpr APIs ([#327](https://github.com/thekorn/sourcepoint_unified_cmp/issues/327)). ([0e980f7f](https://github.com/thekorn/sourcepoint_unified_cmp/commit/0e980f7fcb72660dd8de79aa971de88b9f97510f))

## 0.2.1

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.2.1`.

## 0.2.0

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.2.0`.

## 0.1.31

## 0.1.30

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.30`.

## 0.1.29

## 0.1.28

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.28`.

## 0.1.27

## 0.1.26

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.26`.

## 0.1.25

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.25`.

## 0.1.24

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.24`.

## 0.1.23

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: remove viewId from event delegate.

## 0.1.22

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.22`.

## 0.1.21

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.21`.

## 0.1.20+2

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.20+2`.

## 0.1.20+1

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.20+1`.

## 0.1.20

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.20`.

## 0.1.19

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.19`.

## 0.1.18

## 0.1.17

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.17`.

## 0.1.16

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.16`.

## 0.1.15

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.15`.

## 0.1.14

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.14`.

## 0.1.13

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.13`.

## 0.1.12

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.12`.

## 0.1.11+5

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.11+5`.

## 0.1.11+4

## 0.1.11+3

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.11+3`.

## 0.1.11+2

 - **FEAT**: SourcepointController - its now a `ChangeNotifier` for SPConsent.

## 0.1.11+1

## 0.1.10+1

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.10+1`.

## 0.1.11

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.11`.

## 0.1.10

 - **REFACTOR**(sourcepoint_unified_cmp): split large sourcepoint_unified_cmp.dart into smaller files for better maintainability.

## 0.1.9

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.9`.

## 0.1.8

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.8`.

## 0.1.7

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.7`.

## 0.1.6+1

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.6+1`.

## 0.1.6

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.6`.

## 0.1.5

 - Bump "sourcepoint_unified_cmp_platform_interface" to `0.1.5`.

## 0.1.4

 - **REFACTOR**(sourcepoint_unified_cmp_platform_interface): update test setup and dependencies.
 - **DOCS**: add workflow status badges to README files for better visibility of project status.

## 0.1.3

 - version bump

## 0.1.2+1

 - **FIX**(typos): Correct various typos across multiple files.

## 0.1.2

## 0.1.1

 - **REFACTOR**(sourcepoint_unified_cmp_platform_interface): move interface implementation to separate file for better code organization.
 - **REFACTOR**(sourcepoint_unified_cmp): replace HostAPISourcepointUnifiedCmpError with HostAPISPError for better error handling.
 - **FEAT**(sourcepoint_unified_cmp): add loadPrivacyManager method to load Privacy Manager on demand.
 - **FEAT**(sourcepoint_unified_cmp): add support for configurable message language, campaigns environment, message timeout, and campaigns.
 - **FEAT**(sourcepoint_unified_cmp): add event delegate to handle consent events.
 - **FEAT**(sourcepoint_unified_cmp): change loadMessage return type from void to bool to provide feedback on operation success.
 - **FEAT**(sourcepoint_unified_cmp_platform_interface): add load() method to handle initial privacy manager loading and consent.
 - **DOCS**: add BSD 3-Clause License to sourcepoint_unified_cmp, sourcepoint_unified_cmp_android, sourcepoint_unified_cmp_ios, and sourcepoint_unified_cmp_platform_interface packages for legal compliance.

# 0.1.0+1

* Initial release.
