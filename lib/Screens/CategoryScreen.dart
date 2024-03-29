import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import "../Widgets/CategoryWidget.dart";
import "../Classes/Basket.dart";
import '../Classes/Procucts.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';

class CategoryScreen extends StatefulWidget {
  
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool dataIsAvailable = false;
  bool isRefreshing = false;

  refresh(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;
    String index = ModalRoute.of(context).settings.arguments.toString();
    
    return DefaultTabController(
      initialIndex: int.parse(index),
      length: Products.categories.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.75),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo-01.png", 
            height: 25,
          ),
          actions: [
            GestureDetector(
              onTap: (){
                setState(() {
                  isRefreshing = true;
                });
                Future.delayed(const Duration(milliseconds: 500), (){
                  Navigator.of(context).pop("refresh");
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: isRefreshing 
                ? Image.asset("assets/images/theLoading.gif", scale: 12, alignment: Alignment.centerRight,)
                : Icon(Icons.refresh),
              ),
            )
          ],
          backgroundColor: Colors.yellow[200],
          bottom: TabBar(
            labelColor: Colors.black.withOpacity(0.75),
            unselectedLabelColor: Colors.black.withOpacity(0.75),
            indicatorColor: Colors.black.withOpacity(0.75),
            isScrollable: true,
            tabs: [
              for(var item in Products.categories)
              Tab(icon: Text(jsonDecode(item["name"])[UserInformation.language], style: GoogleFonts.almarai(color: Colors.black.withOpacity(0.75)),)),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                for(var item in Products.categories)
                CategoryWidget(jsonDecode(item["name"])["en"], refresh),
              ],
            ),
            AnimatedPositioned(
              bottom: int.parse(Basket.getItemsTotalNumber()) >= 1 ? 15 : -80,
              left: theWidth / 2 - (225 / 2),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/basket").then((value) => setState((){}));
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.yellow[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: -10,
                        blurRadius: 15,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      Text(Dictionairy.words["Go to Basket"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75)),)
                    ],
                  ),
                ),
              ), 
            ),
          ],
        ),
      ),
    );
  }
}
