# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-01-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sourcepoint_unified_cmp` - `v0.1.2`](#sourcepoint_unified_cmp---v012)

---

#### `sourcepoint_unified_cmp` - `v0.1.2`


## 2024-01-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sourcepoint_unified_cmp` - `v0.1.1`](#sourcepoint_unified_cmp---v011)
 - [`sourcepoint_unified_cmp_android` - `v0.1.1`](#sourcepoint_unified_cmp_android---v011)
 - [`sourcepoint_unified_cmp_ios` - `v0.1.1`](#sourcepoint_unified_cmp_ios---v011)
 - [`sourcepoint_unified_cmp_platform_interface` - `v0.1.1`](#sourcepoint_unified_cmp_platform_interface---v011)

---

#### `sourcepoint_unified_cmp` - `v0.1.1`

 - **REFACTOR**(sourcepoint_unified_cmp): replace HostAPISourcepointUnifiedCmpError with HostAPISPError for better error handling.
 - **FEAT**: add support for ConsentViewController in sourcepoint_unified_cmp_ios.
 - **FEAT**(sourcepoint_unified_cmp): add loadPrivacyManager method to load Privacy Manager on demand.
 - **FEAT**(sourcepoint_unified_cmp): add support for configurable message language, campaigns environment, message timeout, and campaigns.
 - **FEAT**(sourcepoint_unified_cmp): add event delegate to handle consent events.
 - **FEAT**(sourcepoint_unified_cmp): change loadMessage return type from void to bool to provide feedback on operation success.
 - **FEAT**(sourcepoint_unified_cmp): add MockController, types and widget for consent management.
 - **DOCS**: add BSD 3-Clause License to sourcepoint_unified_cmp, sourcepoint_unified_cmp_android, sourcepoint_unified_cmp_ios, and sourcepoint_unified_cmp_platform_interface packages for legal compliance.

#### `sourcepoint_unified_cmp_android` - `v0.1.1`

 - **REFACTOR**(sourcepoint_unified_cmp): replace HostAPISourcepointUnifiedCmpError with HostAPISPError for better error handling.
 - **FEAT**(sourcepoint_unified_cmp): add loadPrivacyManager method to load Privacy Manager on demand.
 - **FEAT**(sourcepoint_unified_cmp): add support for configurable message language, campaigns environment, message timeout, and campaigns.
 - **FEAT**(sourcepoint_unified_cmp): add event delegate to handle consent events.
 - **FEAT**(sourcepoint_unified_cmp): change loadMessage return type from void to bool to provide feedback on operation success.
 - **DOCS**: add BSD 3-Clause License to sourcepoint_unified_cmp, sourcepoint_unified_cmp_android, sourcepoint_unified_cmp_ios, and sourcepoint_unified_cmp_platform_interface packages for legal compliance.

#### `sourcepoint_unified_cmp_ios` - `v0.1.1`

 - **REFACTOR**(sourcepoint_unified_cmp): replace HostAPISourcepointUnifiedCmpError with HostAPISPError for better error handling.
 - **REFACTOR**(sourcepoint_unified_cmp_ios): remove unnecessary NSLog statements for cleaner code.
 - **FEAT**(sourcepoint_unified_cmp_ios): add support for message language and campaign environment.
 - **FEAT**(sourcepoint_unified_cmp_ios): add SourcepointUnifiedCmpData.swift for data handling.
 - **FEAT**(sourcepoint_unified_cmp_ios): add loadMessage and loadPrivacyManager methods to support loading messages and privacy manager.
 - **FEAT**: add support for ConsentViewController in sourcepoint_unified_cmp_ios.
 - **DOCS**: add BSD 3-Clause License to sourcepoint_unified_cmp, sourcepoint_unified_cmp_android, sourcepoint_unified_cmp_ios, and sourcepoint_unified_cmp_platform_interface packages for legal compliance.

#### `sourcepoint_unified_cmp_platform_interface` - `v0.1.1`

 - **REFACTOR**(sourcepoint_unified_cmp_platform_interface): move interface implementation to separate file for better code organization.
 - **REFACTOR**(sourcepoint_unified_cmp): replace HostAPISourcepointUnifiedCmpError with HostAPISPError for better error handling.
 - **FEAT**(sourcepoint_unified_cmp): add loadPrivacyManager method to load Privacy Manager on demand.
 - **FEAT**(sourcepoint_unified_cmp): add support for configurable message language, campaigns environment, message timeout, and campaigns.
 - **FEAT**(sourcepoint_unified_cmp): add event delegate to handle consent events.
 - **FEAT**(sourcepoint_unified_cmp): change loadMessage return type from void to bool to provide feedback on operation success.
 - **FEAT**(sourcepoint_unified_cmp_platform_interface): add load() method to handle initial privacy manager loading and consent.
 - **DOCS**: add BSD 3-Clause License to sourcepoint_unified_cmp, sourcepoint_unified_cmp_android, sourcepoint_unified_cmp_ios, and sourcepoint_unified_cmp_platform_interface packages for legal compliance.
