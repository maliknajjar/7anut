import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              bottom: 54.5,
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
          Positioned(
            bottom: 0,
            width: theWidth,
            height: 55,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF5DA7E6),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 35,
                    color: Color(0xFF303030),
                  ),
                  Icon(
                    Icons.search,
                    size: 35,
                    color: Color(0xFF303030),
                  ),
                  // NULL space for design \/ \/ \/ \/ \/
                  Icon(Icons.ac_unit),
                  // NULL space for design /\ /\ /\ /\ /\
                  Icon(
                    Icons.location_on,
                    size: 35,
                    color: Color(0xFF303030),
                  ),
                  Icon(
                    Icons.menu,
                    size: 35,
                    color: Color(0xFF303030),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: -10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  print("this realy works man");
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFFFCF555),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                    shape: BoxShape.circle,  
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Color(0xFF303030),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
