import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import './UserInformation.dart';

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

  static List<dynamic> getCurrentUserAddresses(){
    var email = UserInformation.email;
    List<dynamic> newArr = [];
    for (var i = 0; i < addressesBasket.length; i++) {
      if (addressesBasket[i]["email"] == email){
        newArr.add(addressesBasket[i]);
      }
    }
    return newArr;
  }

  static bool isEmpty(){
    var email = UserInformation.email;
    for (var i = 0; i < addressesBasket.length; i++) {
      if (addressesBasket[i]["email"] == email) return true;
    }
    return false;
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