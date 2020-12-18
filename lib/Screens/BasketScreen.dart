import 'package:flutter/material.dart';

// classes
import '../Classes/Basket.dart';

class BasketScreen extends StatefulWidget {
  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            } 
          ),
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
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    for (int i = 0; i < Basket.basketItems.length; i++)
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: Colors.grey[200],
                            ),
                          ),
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
                                        Basket.basketItems[i]["imageUrl"],
                                      ),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Basket.basketItems[i]["Name"],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            Basket.basketItems[i]["price"] + " DT",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]
                                            ),
                                          ),
                                          Text(
                                            Basket.basketItems[i]["size"],
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          "Total: " + (double.parse(Basket.basketItems[i]["price"]) * Basket.basketItems[i]["qty"]).toStringAsFixed(2) + " DT",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 100,
                              width: 90,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
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
                                    child: Center(child: Text(Basket.basketItems[i]["qty"].toString(), style: TextStyle(fontSize: 30),)),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              Basket.addItem(Basket.basketItems[i]["ID"], Basket.basketItems[i]["Name"], Basket.basketItems[i]["size"], Basket.basketItems[i]["imageUrl"], Basket.basketItems[i]["price"].toString());
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              Basket.removeItem(Basket.basketItems[i]["ID"]);
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
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
                      )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xFFFCF555),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Checkout  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(Basket.getUltimateTotal().toStringAsFixed(2) + " DT", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                )
              ),
            )
          ],
        ));
  }
}
