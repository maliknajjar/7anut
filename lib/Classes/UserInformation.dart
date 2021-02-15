import 'package:shared_preferences/shared_preferences.dart';

class UserInformation {
  static String email;
  static String sessionID;
  static String fullName;
  static String phoneNumber;
  static String language;

  UserInformation(){
    SharedPreferences.getInstance().then((prefs){
      email = prefs.getString("email");
      sessionID = prefs.getString("sessionID");
      fullName = prefs.getString("full name");
      phoneNumber = prefs.getString("phone number");
      language = prefs.getString("language");
    });
  }
}