class Basket {
  static var basketItems = [];

  static int getItemNumber(String itemID){
    
  }

  static void printAllSelectedItems(){
    print(Basket.basketItems);
  }

  static void addItem(String itemID){
    basketItems.add({"ID": itemID, "qty": 1});
  }
}