// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

class SPConfig {
  SPConfig({
    required this.accountId,
    required this.propertyId,
    required this.propertyName,
    required this.pmId,
  });
  final int accountId;
  final int propertyId;
  final String propertyName;
  final String pmId;
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    //dartTestOut: 'test/test_android_webview.g.dart',
    dartOptions: DartOptions(
      copyrightHeader: <String>[
        //'Copyright 2013 The Flutter Authors. All rights reserved.',
        //'Use of this source code is governed by a BSD-style license that ',
        //'can be found in the LICENSE file.',
      ],
    ),
    kotlinOut:
        'android/src/main/kotlin/de/thekorn/sourcepoint/unified/cmp/SourcepointUnifiedCmp.g.kt',
    kotlinOptions: KotlinOptions(),
  ),
)
@HostApi()
abstract class SourcepointUnifiedCmpApi {
  @async
  void loadPrivacyManager({
    required int accountId,
    required int propertyId,
    required String propertyName,
    required String pmId,
  });

  @async
  void showPrivacyManager(SPConfig config);

  @async
  void setPlatformCmpConfig(SPConfig config);

  @async
  void init({
    required int accountId,
    required int propertyId,
    required String propertyName,
    required String pmId,
  });
}
