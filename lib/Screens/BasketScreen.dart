import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  final int theLimit = 2;

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
      body: Container(
        padding: EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for(int i = 1; i <= theLimit; i++)
              Container(
                margin: EdgeInsets.only(bottom: i == theLimit  ? 20 : 0, left: 0, right: 0, top: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
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
                          child: Text("malikoooooo"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.keyboard_arrow_up),
                        Text("5"),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
