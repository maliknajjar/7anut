class Products {
  static var products;
  static var categories;

  static List getProductsByCategory(String cat){
    List productsArr = [];
    for(int i = 0; i < Products.products.length; i++){
      if(Products.products[i]["category"] == cat) productsArr.add(Products.products[i]);
    }
    return productsArr;
  }
}