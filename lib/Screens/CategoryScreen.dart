import 'package:flutter/material.dart';

import "../Widgets/CategoryWidget.dart";

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 14,
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
              Tab(icon: Text("New products")),
              Tab(icon: Text("water")),
              Tab(icon: Text("Fruits and vegetables")),
              Tab(icon: Text("Baked goods")),
              Tab(icon: Text("Snacks")),
              Tab(icon: Text("icecream")),
              Tab(icon: Text("food")),
              Tab(icon: Text("drinks")),
              Tab(icon: Text("Basic materials")),
              Tab(icon: Text("Personal care")),
              Tab(icon: Text("Electronics")),
              Tab(icon: Text("Animal food")),
              Tab(icon: Text("kids Accessories")),
              Tab(icon: Text("Clothes")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
