class Items {
  static var selectedItemsMap = {};

  static void printAllSelectedItems(){
    selectedItemsMap.forEach((key, value) {
      print("\nkey: " + key + "\nvalue: " + value);
    });
  }

  static void addItem(String itemName){
    
  }
}