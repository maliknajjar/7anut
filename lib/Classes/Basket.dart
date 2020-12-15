class Basket {
  static var basketItems = [];

  static void printAllSelectedItems(){
    print(Basket.basketItems);
  }

  static void addItem(String itemID, String itemName, String itemSize, String itemImageUrl){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"]++;
        return;
      }
    }
    basketItems.add({"ID": itemID, "Name": itemName, "size": itemSize, "imageUrl": itemImageUrl,  "qty": 1});
  }

  static void removeItem(String itemID){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"]--;
        if(Basket.basketItems[i]["qty"] == 0) Basket.basketItems.removeAt(i);
        return;
      }
    }
  }
}