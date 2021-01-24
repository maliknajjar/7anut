import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Addresses {
  static var addressesBasket = [];
  
  Addresses(){
    SharedPreferences.getInstance().then((prefs){
      print("ahahahahahaha");
      if(prefs.getString("addresses") != null){
        addressesBasket = jsonDecode(prefs.getString("addresses"));
      }
    });
  }

  static void refreshStorage(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("addresses", jsonEncode(addressesBasket));
    });
  }

  static void addAddress(address){
    addressesBasket.add(address);
    refreshStorage();
  }

  static void deleteAddress(addressIndex){
    addressesBasket.removeAt(addressIndex);
    refreshStorage();
  }
}