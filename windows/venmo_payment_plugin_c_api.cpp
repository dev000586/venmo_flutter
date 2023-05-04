#include "include/venmo_payment/venmo_payment_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "venmo_payment_plugin.h"

void VenmoPaymentPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  venmo_payment::VenmoPaymentPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
