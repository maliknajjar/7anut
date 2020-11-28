import 'package:flutter/material.dart';

// importing items class
import '../Classes/SelectedItems.dart';

class BasketScreen extends StatelessWidget {
  final int itemsNumber = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF5DA7E6),
          iconTheme: IconThemeData(
            color: Color(0xFF303030),
          ),
          title: Text(
            "Basket",
            style: TextStyle(
              color: Color(0xFF303030),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 1; i <= itemsNumber; i++)
                      Container(
                        margin: EdgeInsets.only(
                            bottom: i == itemsNumber ? 20 : 0,
                            left: 0,
                            right: 0,
                            top: 0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                              width: i == 1 ? 0 : 2,
                              color: Colors.grey[200],
                            ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn.shopify.com/s/files/1/1698/1675/products/Tomato_Thessaloniki.jpg?v=1537070112"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 90,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "hahahahaha",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "hahahahaha",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 100,
                              width: 50,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: 60,
                                    child: InkWell(
                                      onTap: (){
                                        Items.printAllSelectedItems();
                                      },
                                      child: Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 50,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    child: InkWell(
                                      onTap: (){
                                        print("hahahaha");
                                      },
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 50,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
