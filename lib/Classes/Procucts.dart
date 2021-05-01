class Products {
  static var products;
  static var categories;
  static List<String> favourite;

  static List searchProductsByName(String productName){
    List searchedItems = [];
    int number = 0;
    if(productName.isEmpty) return searchedItems;
    for (var i = 0; i < products.length; i++) {
      if(number == 20) break;
      if(Products.products[i]["category"] == "Special offers" || Products.products[i]["category"] == "Favourites") continue;
      if(Products.products[i]["Name"].toLowerCase().contains(productName.toLowerCase())) {
        number++;
        searchedItems.add(Products.products[i]);
      }
    }
    print(searchedItems);
    return searchedItems;
  }

  static List getProductsByCategory(String cat){
    List productsArr = [];
    if(cat == "Favourites"){
      for(int i = 0; i < Products.products.length; i++){
        favourite.forEach((element) {
          if(Products.products[i]["Name"].toString() == element) productsArr.add(Products.products[i]);
        });
      }
    }else{
      for(int i = 0; i < Products.products.length; i++){
        if(Products.products[i]["category"] == cat) productsArr.add(Products.products[i]);
      }
    }
    return productsArr;
  }
}