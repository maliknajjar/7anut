import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Classes/Basket.dart';

class CategoryWidget extends StatefulWidget {
  String category;
  CategoryWidget(String cat){
    category = cat;
  }

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState(category);
}

class _CategoryWidgetState extends State<CategoryWidget> {
  var arr;
  String category;
  bool dataIsAvailable = false;

  _CategoryWidgetState(String cat){
    category = cat;
  }

  @override
  initState() {
    super.initState();
    
    http.get("http://10.0.2.2:8000/api/products/" + category).then((r){
      if (this.mounted) {
        setState(() {
          dataIsAvailable = true;
          arr = json.decode(r.body);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;
    var columnMultiplier = 1;
    theWidth /= columnMultiplier;

    return !dataIsAvailable 
    ? Container(color: Colors.white70, child: Center(child: Image.asset("assets/images/logo-01.png", height: 100, width: 100,))) 
    : Container(
      padding: EdgeInsets.only(
        // bottom: 100.5,
      ),
      color: Color(0xFF5DA7E6).withOpacity(0.1),
      width: double.infinity,
      child: GridView.count(
        padding: EdgeInsets.only(
          top: theWidth * 0.05,
          bottom: 15,
          right: theWidth * 0.025,
          left: theWidth * 0.025,
        ),
        mainAxisSpacing: 15,
        crossAxisSpacing: theWidth * 0.05,
        crossAxisCount: 3 * columnMultiplier,
        childAspectRatio: 0.69,
        children: <Widget>[
          for(var item in arr ) 
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item["imageUrl"]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(theWidth * 0.06),
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
                    Positioned(
                      right: theWidth * 0.0225,
                      top: theWidth * 0.0225,
                      child: InkWell(
                        onTap: (){
                          Basket.addItem(item["ID"].toString());
                          Basket.printAllSelectedItems();
                        },
                        child: Container(
                          height: theWidth * 0.085,
                          width: theWidth * 0.085,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(theWidth * 0.035),
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
                          child: Icon(Icons.add, size: theWidth * 0.07,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 7.5,
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["Name"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: theWidth * 0.04,
                        ),
                      ),
                      Text(
                        item["size"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: theWidth * 0.04,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
