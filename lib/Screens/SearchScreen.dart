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
          color: Color(0xFF303030),
        ),
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
        backgroundColor: Color(0xFF5DA7E6),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(0.5),
                ),
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
            searchTerm == null 
            ? Expanded(
              child: Container(
                child: Icon(Icons.search, size: 0.3 * width, color: Colors.black.withOpacity(0.25),),
              ),
            )
            : Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: Products.searchProductsByName(searchTerm).contains("no resluts")
                ? [Text("No Results", style: TextStyle(fontSize: 22),)]
                : Products.searchProductsByName(searchTerm).map((e){
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15)
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
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1
                                ),
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
                              margin: EdgeInsets.only(left: 10),
                              child: Container(
                                height: 0.20 * width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e["Name"], style: TextStyle(fontSize: 16),),
                                    Text(e["price"].toString(), style: TextStyle(fontSize: 16),),
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
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1
                                    ),
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
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1
                                    ),
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