import 'package:flutter/material.dart';

import '../Classes/Procucts.dart';

class SearchScreen extends StatelessWidget {
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
                onChanged: (string){
                  
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
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: Products.searchProductsByName("chocotom").map((e){
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
                              Container(
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
                              Container(
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