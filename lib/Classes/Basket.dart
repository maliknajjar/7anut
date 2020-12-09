class Basket {
  static var basketItems = [];

  static void printAllSelectedItems(){
    print(Basket.basketItems);
  }

  static void addItem(String itemName){
    basketItems.add(itemName);
  }
}