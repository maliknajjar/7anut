import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  var arr;
  bool dataIsAvailable = false;

  @override
  initState() {
    super.initState();
    
    http.get("http://localhost:8000/products?json").then((r){
      setState(() {
        dataIsAvailable = true;
        arr = json.decode(r.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;

    return !dataIsAvailable 
    ? Center(child: Text("loading products")) 
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
        crossAxisCount: 3,
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
                    Positioned(
                      right: 7.5,
                      top: 7.5,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
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
                        child: Icon(Icons.add),
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
