import 'package:flutter/material.dart';

import "../Widgets/CategoryWidget.dart";

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 3,
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
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoryWidget(),
            CategoryWidget(),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
