import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context).settings.arguments;
    var theWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
      ),
      body: Container(
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
          crossAxisCount: 4,
          childAspectRatio: 0.75,
          children: <Widget>[
            for (var i = 0; i < 30; i++)
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.shopify.com/s/files/1/1698/1675/products/Tomato_Thessaloniki.jpg?v=1537070112"),
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
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 7.5,
                      ),
                      child: Center(
                        child: Text(
                          "maliko",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: theWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
