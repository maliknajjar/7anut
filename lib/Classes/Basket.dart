class Basket {
  static List basketItems = [];
  static Map simpleArray = {};

  static void clearBasket(){
    basketItems.clear();
  }

  static void addItem(String itemID, String itemName, String itemSize, String itemImageUrl, String itemPrice, int itemUserLimit){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"]++;
        return;
      }
    }
    basketItems.add({"ID": itemID, "Name": itemName, "size": itemSize, "imageUrl": itemImageUrl, "price": itemPrice, "limit_amount_per_user": itemUserLimit, "qty": 1});
  }

  static void removeItem(String itemID){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"]--;
        if(Basket.basketItems[i]["qty"] <= 0) Basket.basketItems.removeAt(i);
        return;
      }
    }
  }

  static void changeItemQty(String itemID, String itemQty){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"] = int.parse(itemQty);
        return;
      }
    }
  }

  static String getItemsTotalNumber(){
    int totalNumber = 0;
    for(int i = 0; i < Basket.basketItems.length; i++){
      totalNumber += Basket.basketItems[i]["qty"];
    }
    if(totalNumber == 0) return "0";
    return totalNumber.toString();
  }

  static String getItemsTotalTypeNumber(){
    return Basket.basketItems.length.toString();
  }

  static String getQtyById(String id, {bool forAnimation}){
    int totalNumber = 0;
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == id) totalNumber += Basket.basketItems[i]["qty"];
    }
    if(totalNumber == 0) return forAnimation == null ? "" : "0";
    return totalNumber.toString();
  }

  static double getUltimateTotal(){
    double totalNumber = 0;
    for(int i = 0; i < Basket.basketItems.length; i++){
      totalNumber += Basket.basketItems[i]["qty"] * double.parse(Basket.basketItems[i]["price"]);
    }
    return totalNumber;
  }

  static void addItemToSimpleMap(productID){
    if(!simpleArray.containsKey(productID)) simpleArray[productID] = 0;
    simpleArray[productID]++;
  }

  static void removeItemToSimpleMap(productID){
    simpleArray[productID]--;
    if(simpleArray[productID] == 0) simpleArray.remove(productID);
  }
}