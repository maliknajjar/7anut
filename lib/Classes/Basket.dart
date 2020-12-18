class Basket {
  static var basketItems = [];

  static void printAllSelectedItems(){
    print(Basket.basketItems);
  }

  static void addItem(String itemID, String itemName, String itemSize, String itemImageUrl, String itemPrice){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"]++;
        return;
      }
    }
    basketItems.add({"ID": itemID, "Name": itemName, "size": itemSize, "imageUrl": itemImageUrl, "price": itemPrice, "qty": 1});
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

  static String getQtyById(String id){
    int totalNumber = 0;
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == id) totalNumber += Basket.basketItems[i]["qty"];
    }
    if(totalNumber == 0) return "";
    return totalNumber.toString();
  }
}