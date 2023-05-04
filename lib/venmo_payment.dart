
import 'venmo_payment_platform_interface.dart';

class VenmoPayment {
  Future<String?> getPlatformVersion() {
    return VenmoPaymentPlatform.instance.getPlatformVersion();
  }
  static void initialize({required String appId, required String secret, required String name}) async {
    return VenmoPaymentPlatform.instance.initialize(appId: appId, secret: secret, name: name);
  }

  static Future<Map> createPayment({required String recipientUsername, required int fineAmount, required String description}) async {
    return VenmoPaymentPlatform.instance.createPayment(recipientUsername: recipientUsername, fineAmount: fineAmount, description: description);
  }
}
