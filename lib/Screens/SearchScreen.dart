import 'package:flutter/material.dart';

import '../Classes/Procucts.dart';
import '../Classes/Basket.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        backgroundColor: Colors.yellow[200],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(5, 5)
                  ),
                ],
                borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow[50],
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      BoxShadow(
                        spreadRadius: 4,
                        blurRadius: 5,
                        color: Colors.white,
                        offset: Offset(10, 10)
                      ),
                      BoxShadow(
                        spreadRadius: -5,
                        blurRadius: 20,
                        color: Colors.yellow[100],
                        offset: Offset(-5, -2.5)
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    onSubmitted: (string){
                      setState(() {
                        searchTerm = string;                  
                      });
                    },
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: "Search"
                    ),
                  ),
                ),
              ),
            ),
            searchTerm == null 
            ? Container()
            : Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: Products.searchProductsByName(searchTerm).contains("no results")
                ? [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text("No Results", style: TextStyle(fontSize: 22),),
                  )
                ]
                : Products.searchProductsByName(searchTerm).map((e){
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow[50],
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(2.5, 2.5),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 0.20 * width,
                              height: 0.20 * width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(e["imageUrl"]),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7.5,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(2.5, 2.5),
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: FittedBox(
                                child: Text(
                                  Basket.getQtyById(
                                    e["ID"].toString(),
                                  ),
                                  style: TextStyle(
                                    fontSize: 110,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Container(
                                height: 0.20 * width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e["Name"], style: TextStyle(fontSize: 16),),
                                    Text(e["price"].toString() + " DT", style: TextStyle(fontSize: 16),),
                                    Text(e["size"].toString(), style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
                          margin: EdgeInsets.only(right: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Basket.addItem(e["ID"].toString(), e["Name"], e["size"], e["imageUrl"], e["price"].toString());
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                  ),
                                  child: Center(child: Text("+", style: TextStyle(fontSize: 25),)),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Basket.removeItem(e["ID"].toString());
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                  ),
                                  child: Center(child: Text("-", style: TextStyle(fontSize: 25),)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList()
              ),
            )
          ],
        ),
      )
    );
  }
}