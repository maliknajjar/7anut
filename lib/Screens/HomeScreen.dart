import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Screens/LoadingLogoScreen.dart';
import '../Widgets/DrawerWidget.dart';
import '../Classes/Procucts.dart';
import '../env.dart';

import '../Classes/Adresses.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var products;
  bool dataIsAvailable = false;

  @override
  initState() {
    super.initState();

    // adding the stored addresses to the address variable array
    print("done done done done done done done done done done done done done done done done done ");
    Addresses();
    
    http.get(env.apiUrl + "/api/categories").then((r){
      products = json.decode(r.body);
      Products.categories= json.decode(r.body);
    }).then((value){
      http.get(env.apiUrl + "/api/products/").then((r){
        if (this.mounted) {
          setState(() {
            dataIsAvailable = true;
            Products.products = json.decode(r.body);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: TheDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: !dataIsAvailable ? Colors.blue[100] : Color(0xFF303030),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo-01.png", 
          height: 25,
        ),
        backgroundColor: Color(0xFF5DA7E6),
      ),
      body: !dataIsAvailable 
      ? LoadingLogo()
      : Stack(
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
                for(var item in products)
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed("/category", arguments: item["ID"] - 1);
                  },
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
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
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: 7.5,
                          ),
                          child: Center(
                            child: Text(
                              item["name"],
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
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/profile");
                    },
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: 35,
                    color: Color(0xFF303030),
                  ),
                  // NULL space for design \/ \/ \/ \/ \/
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Icon(Icons.ac_unit),
                  ),
                  // NULL space for design /\ /\ /\ /\ /\
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/adresses");
                    },
                    child: Icon(
                      Icons.location_on,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/orders");
                    },
                    child: Icon(
                      Icons.access_time,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: -5,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/basket");
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
