import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import "../Widgets/CategoryWidget.dart";

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var arr;
  bool dataIsAvailable = false;

  @override
  initState() {
    super.initState();
    
    http.get("http://10.0.2.2:8000/categories").then((r){
      setState(() {
        dataIsAvailable = true;
        arr = json.decode(r.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: !dataIsAvailable ? 0 : arr.length,
      child: !dataIsAvailable 
      ? Scaffold(backgroundColor: Colors.grey[200], body: Center(child: Image.asset("assets/images/logo-01.png", height: 100, width: 100,)))
      : Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.shopping_cart,
                size: 25,
                color: Color(0xFF303030),
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: Color(0xFF303030),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo-01.png", 
            height: 25,
          ),
          backgroundColor: Color(0xFF5DA7E6),
          bottom: TabBar(
            labelColor: Color(0xFF303030),
            unselectedLabelColor: Color(0xFF303030),
            indicatorColor: Color(0xFFFCF555),
            isScrollable: true,
            tabs: [
              for(var item in arr)
              Tab(icon: Text(item["name"])),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for(var item in arr)
            CategoryWidget(item["name"]),
          ],
        ),
      ),
    );
  }
}
