// Mocks generated by Mockito 5.4.4 from annotations
// in sourcepoint_unified_cmp_platform_interface/test/sourcepoint_unified_cmp_platform_interface_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter/services.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sourcepoint_unified_cmp_platform_interface/src/change_notifier.dart'
    as _i7;
import 'package:sourcepoint_unified_cmp_platform_interface/src/interface.dart'
    as _i6;
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart'
    as _i4;
import 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMethodChannel_0 extends _i1.SmartFake implements _i2.MethodChannel {
  _FakeMethodChannel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSPConsent_1 extends _i1.SmartFake implements _i3.SPConsent {
  _FakeSPConsent_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MethodChannelSourcepointUnifiedCmp].
///
/// See the documentation for Mockito's code generation for more information.
class MockMethodChannelSourcepointUnifiedCmp extends _i1.Mock
    implements _i4.MethodChannelSourcepointUnifiedCmp {
  @override
  _i2.MethodChannel get methodChannel => (super.noSuchMethod(
        Invocation.getter(#methodChannel),
        returnValue: _FakeMethodChannel_0(
          this,
          Invocation.getter(#methodChannel),
        ),
        returnValueForMissingStub: _FakeMethodChannel_0(
          this,
          Invocation.getter(#methodChannel),
        ),
      ) as _i2.MethodChannel);

  @override
  _i5.Future<_i3.SPConsent> loadMessage(_i3.SPConfig? config) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadMessage,
          [config],
        ),
        returnValue: _i5.Future<_i3.SPConsent>.value(_FakeSPConsent_1(
          this,
          Invocation.method(
            #loadMessage,
            [config],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.SPConsent>.value(_FakeSPConsent_1(
          this,
          Invocation.method(
            #loadMessage,
            [config],
          ),
        )),
      ) as _i5.Future<_i3.SPConsent>);

  @override
  _i5.Future<void> loadPrivacyManager(
    String? pmId,
    _i3.PMTab? pmTab,
    _i3.CampaignType? campaignType,
    _i3.MessageType? messageType,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadPrivacyManager,
          [
            pmId,
            pmTab,
            campaignType,
            messageType,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void registerEventDelegate(_i6.SourcepointEventDelegatePlatform? delegate) =>
      super.noSuchMethod(
        Invocation.method(
          #registerEventDelegate,
          [delegate],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerConsentChangeNotifier(_i7.ConsentChangeNotifier? notifier) =>
      super.noSuchMethod(
        Invocation.method(
          #registerConsentChangeNotifier,
          [notifier],
        ),
        returnValueForMissingStub: null,
      );
}
