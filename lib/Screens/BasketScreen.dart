import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// classes
import '../Classes/Basket.dart';

class BasketScreen extends StatelessWidget {
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
                    for (int i = 1; i <= 10; i++)
                      Container(
                        margin: EdgeInsets.only(
                            bottom: i == 10 ? 20 : 0,
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
                              width: 75,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("0"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("+"),
                                      Text("-"),
                                    ],
                                  )
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
