import 'package:shared_preferences/shared_preferences.dart';

class UserInformation {
  static String email;
  static String sessionID;

  UserInformation(){
    SharedPreferences.getInstance().then((prefs){
      email = prefs.getString("email");
      sessionID = prefs.getString("sessionID");
    });
  }
}