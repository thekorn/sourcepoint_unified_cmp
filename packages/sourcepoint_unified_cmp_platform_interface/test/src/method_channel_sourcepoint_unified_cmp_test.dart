//import 'package:flutter/services.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel_sourcepoint_unified_cmp.dart';
//
//void main() {
//  TestWidgetsFlutterBinding.ensureInitialized();
//
//  group('$MethodChannelSourcepointUnifiedCmp', () {
//    late MethodChannelSourcepointUnifiedCmp methodChannelSourcepointUnifiedCmp;
//    final log = <MethodCall>[];
//
//    setUp(() async {
//      methodChannelSourcepointUnifiedCmp = MethodChannelSourcepointUnifiedCmp();
//      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//          .setMockMethodCallHandler(
//        methodChannelSourcepointUnifiedCmp.methodChannel,
//        (methodCall) async {
//          log.add(methodCall);
//          switch (methodCall.method) {
//            case 'loadPrivacyManager':
//              break;
//            default:
//              return null;
//          }
//        },
//      );
//    });
//
//    tearDown(log.clear);
//
//    test('loadPrivacyManager', () async {
//      await methodChannelSourcepointUnifiedCmp.loadPrivacyManager();
//      expect(
//        log,
//        <Matcher>[isMethodCall('loadPrivacyManager', arguments: null)],
//      );
//    });
//  });
//}

void main() {}
