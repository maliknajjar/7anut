import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';

class UserInformation {
  static String email;
  static String sessionID;
  static String fullName;
  static String phoneNumber;
  static String language;

  static String appName;
  static String packageName;
  static String version;
  static String buildNumber;

  static String deviceID;

  UserInformation(){
    SharedPreferences.getInstance().then((prefs){
      email = prefs.getString("email");
      sessionID = prefs.getString("sessionID");
      fullName = prefs.getString("full name");
      phoneNumber = prefs.getString("phone number");
      language = prefs.getString("language");
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });

    printModel();
  }

  void printModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.id;
    }else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
    }else{
      deviceID = "null";
    }
  }
}