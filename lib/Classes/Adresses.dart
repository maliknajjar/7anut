class Addresses {
  static List<dynamic> addressesBasket = [];

  static dynamic getAddressById(int id){
    for (var i = 0; i < addressesBasket.length; i++) {
      if(addressesBasket[i]["ID"] == id) {
        print(addressesBasket[i]);
        return addressesBasket[i];
      }
    }
  }

  static void edit(int id, var addresse){
    for (var i = 0; i < addressesBasket.length; i++) {
      if(addressesBasket[i]["ID"] == id) {
        addressesBasket[i]["addresse"] = addresse;
        return;
      }
    }
  }
}