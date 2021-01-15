import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Addresses {
  static var addressesBasket = [];
  
  Addresses(){
    // before anything you should add the addresses in the storage to the addressesBasket static variable
  }

  static void addAddress(address){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("addresses", jsonEncode(addressesBasket));
    });
  }
}