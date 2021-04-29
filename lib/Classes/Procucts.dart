class Products {
  static var products;
  static var categories;
  static List<String> favourite;

  static List searchProductsByName(String productName){
    List searchedItems = [];
    for (var i = 0; i < products.length; i++) {
      // if(Products.products[i]["Name"] == productName) searchedItems.add(Products.products[i]);
      if(Products.products[i]["Name"].toLowerCase().contains(productName.toLowerCase())) searchedItems.add(Products.products[i]);
    }
    if(searchedItems.isEmpty) searchedItems.add("no results");
    return searchedItems;
  }

  static List getProductsByCategory(String cat){
    List productsArr = [];
    if(cat == "Favourites"){
      for(int i = 0; i < Products.products.length; i++){
        favourite.forEach((element) {
          if(Products.products[i]["ID"].toString() == element) productsArr.add(Products.products[i]);
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