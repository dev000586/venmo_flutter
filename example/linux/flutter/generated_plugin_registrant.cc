//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <venmo_payment/venmo_payment_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) venmo_payment_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "VenmoPaymentPlugin");
  venmo_payment_plugin_register_with_registrar(venmo_payment_registrar);
}
