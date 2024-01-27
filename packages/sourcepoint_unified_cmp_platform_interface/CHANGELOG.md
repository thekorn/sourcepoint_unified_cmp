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
