import 'package:flutter_test/flutter_test.dart';
import 'package:venmo_payment/venmo_payment.dart';
import 'package:venmo_payment/venmo_payment_platform_interface.dart';
import 'package:venmo_payment/venmo_payment_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVenmoPaymentPlatform
    with MockPlatformInterfaceMixin
    implements VenmoPaymentPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<Map> createPayment({required String recipientUsername, required int fineAmount, required String description}) {
    throw UnimplementedError();
  }

  @override
  void initialize({required String appId, required String secret, required String name}) {
  }
}

void main() {
  final VenmoPaymentPlatform initialPlatform = VenmoPaymentPlatform.instance;

  test('$MethodChannelVenmoPayment is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVenmoPayment>());
  });

  test('getPlatformVersion', () async {
    VenmoPayment venmoPaymentPlugin = VenmoPayment();
    MockVenmoPaymentPlatform fakePlatform = MockVenmoPaymentPlatform();
    VenmoPaymentPlatform.instance = fakePlatform;

    expect(await venmoPaymentPlugin.getPlatformVersion(), '42');
  });
}
