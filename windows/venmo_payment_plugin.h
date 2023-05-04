#ifndef FLUTTER_PLUGIN_VENMO_PAYMENT_PLUGIN_H_
#define FLUTTER_PLUGIN_VENMO_PAYMENT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace venmo_payment {

class VenmoPaymentPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  VenmoPaymentPlugin();

  virtual ~VenmoPaymentPlugin();

  // Disallow copy and assign.
  VenmoPaymentPlugin(const VenmoPaymentPlugin&) = delete;
  VenmoPaymentPlugin& operator=(const VenmoPaymentPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace venmo_payment

#endif  // FLUTTER_PLUGIN_VENMO_PAYMENT_PLUGIN_H_
