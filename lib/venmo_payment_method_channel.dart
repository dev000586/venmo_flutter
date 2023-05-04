import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'venmo_payment_platform_interface.dart';

/// An implementation of [VenmoPaymentPlatform] that uses method channels.
class MethodChannelVenmoPayment extends VenmoPaymentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('venmo_payment');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void initialize({required String appId, required String secret, required String name}) async {
    Map<String, dynamic> params = <String, dynamic> {
      'appId': appId,
      'secret': secret,
      'name': name,
    };
    await methodChannel.invokeMethod('initializeVenmo', params);
  }

  @override
  Future<Map> createPayment({required String recipientUsername, required int fineAmount, required String description}) async {
    Map<String, dynamic> params = <String, dynamic> {
      'recipientUsername': recipientUsername,
      'amount': fineAmount,
      'note': description,
    };
    final Map response = await methodChannel.invokeMethod('createVenmoPayment', params);
    print("============$response");
    return response;
  }
}
