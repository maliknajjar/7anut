import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserInformation {
  static String email;
  static String sessionID;
  static String fullName;
  static String phoneNumber;
  static String language;

  static String appName = "";
  static String packageName = "";
  static String version = "";
  static String buildNumber = "";

  static String deviceID = "";

  UserInformation(){
    SharedPreferences.getInstance().then((prefs){
      email = prefs.getString("email");
      sessionID = prefs.getString("sessionID");
      fullName = prefs.getString("full name");
      phoneNumber = prefs.getString("phone number");
      language = prefs.getString("language");
    });

    if (kIsWeb) {
      deviceID = "other";
      return;
    }

    saveDeviceID();
  }

  void saveDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.id;
    }else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
    }else{
      deviceID = "other";
    }
  }
}