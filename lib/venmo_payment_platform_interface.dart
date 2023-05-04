import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'venmo_payment_method_channel.dart';

abstract class VenmoPaymentPlatform extends PlatformInterface {
  /// Constructs a VenmoPaymentPlatform.
  VenmoPaymentPlatform() : super(token: _token);

  static final Object _token = Object();

  static VenmoPaymentPlatform _instance = MethodChannelVenmoPayment();

  /// The default instance of [VenmoPaymentPlatform] to use.
  ///
  /// Defaults to [MethodChannelVenmoPayment].
  static VenmoPaymentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VenmoPaymentPlatform] when
  /// they register themselves.
  static set instance(VenmoPaymentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void initialize(
      {required String appId, required String secret, required String name}) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<Map> createPayment(
      {required String recipientUsername, required int fineAmount, required String description}) async {
    throw UnimplementedError('createPayment() has not been implemented.');
  }
}
