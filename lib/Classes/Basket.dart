class Basket {
  static var basketItems = [];

  static int getItemQty(String itemID){
    
  }

  static void printAllSelectedItems(){
    print(Basket.basketItems);
  }

  static void addItem(String itemID){
    for(int i = 0; i < Basket.basketItems.length; i++){
      if(Basket.basketItems[i]["ID"] == itemID){
        Basket.basketItems[i]["qty"]++;
        return;
      }
    }
    basketItems.add({"ID": itemID, "qty": 1});
  }
}