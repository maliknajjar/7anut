import 'package:flutter/material.dart';

import "../Widgets/CategoryWidget.dart";
import "../Classes/Basket.dart";
import '../Classes/Procucts.dart';

class CategoryScreen extends StatefulWidget {
  
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool dataIsAvailable = false;

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
        appBar: AppBar(
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
              for(var item in Products.categories)
              Tab(icon: Text(item["name"])),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                for(var item in Products.categories)
                CategoryWidget(item["name"]),
              ],
            ),
            AnimatedPositioned(
              bottom: int.parse(Basket.getItemsTotalNumber()) >= 1 ? 15 : -80,
              left: theWidth / 2 - (200 / 2),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/basket").then((value) => setState((){}));
                },
                child: Container(
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
                      Icon(
                        Icons.shopping_cart,
                        size: 35,
                        color: Color(0xFF303030),
                      ),
                      Text(" Go to Basket", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
