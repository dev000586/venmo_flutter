package com.dev586.venmo_payment;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.plugin.common.PluginRegistry;


/** VenmoPaymentPlugin */
public class VenmoPaymentPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity


  private Activity activity;
  private MethodChannel channel;
  private final int REQUEST_CODE_VENMO_APP_SWITCH = 1215;
  private Result result;
  private String appId;
  private String secret;
  private String name;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "venmo_payment");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    HashMap response = new HashMap();
    HashMap arguments = (HashMap) call.arguments;
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "initializeVenmo":
        this.appId = (String) arguments.get("appId");
        this.secret = (String) arguments.get("secret");
        this.name = (String) arguments.get("name");
        response.put("success", true);
        result.success(response);
        break;
      case "createVenmoPayment":
        if (VenmoLibrary.isVenmoInstalled(activity.getApplicationContext())) {
          this.result = result;
          String recipientUsername = (String) arguments.get("recipientUsername");
          int amount = (int) arguments.get("amount");
          String note = (String) arguments.get("note");
          Intent venmoIntent = VenmoLibrary.openVenmoPayment(this.appId, this.name, recipientUsername, centsToDollars(amount), note, "pay");
          this.activity.startActivityForResult(venmoIntent, REQUEST_CODE_VENMO_APP_SWITCH);
        } else {
          response.put("success", false);
          response.put("error", "Venmo not installed");
          result.success(response);
        }
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == REQUEST_CODE_VENMO_APP_SWITCH) {
      HashMap response = new HashMap();
      if (resultCode == Activity.RESULT_OK) {
        String signedRequest = data.getStringExtra("signedrequest");
        if (signedRequest != null) {
          VenmoLibrary.VenmoResponse venmoResponse = (new VenmoLibrary()).validateVenmoPaymentResponse(signedRequest, this.secret);
          //Payment successful.  Use data from venmoResponse object to display a success message
          response.put("id", venmoResponse.getPaymentId());
          response.put("amount", venmoResponse.getAmount());
          response.put("success", true);
        } else {
          //An error ocurred.
          response.put("success", false);
          response.put("error", data.getStringExtra("error_message"));
        }
      } else if (resultCode == Activity.RESULT_CANCELED) {
        //The user cancelled the payment
        response.put("success", false);
        response.put("error", "The transaction was incomplete.");
      }
      this.result.success(response);
      return true;
    } else {
      return false;
    }
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

  private String centsToDollars(int cents) {
    if (cents >= 100) {
      String stringCents = cents + "";
      return stringCents.substring(0, stringCents.length() - 2) +
              "." +
              stringCents.substring(stringCents.length() - 2);
    } else if (cents >= 10) {
      return "0." + cents;
    } else {
      return "0.0" + cents;
    }
  }
}
