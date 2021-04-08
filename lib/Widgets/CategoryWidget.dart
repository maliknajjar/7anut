import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Classes/Basket.dart';
import '../Classes/Procucts.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/Functions.dart';
import '../env.dart';

class CategoryWidget extends StatefulWidget {
  String category;
  Function() refresh;
  CategoryWidget(String cat, this.refresh) {
    category = cat;
  }

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState(category);
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String category;
  List<bool> isLoading = [];
  List<bool> isLoadingForMinus = [];

  _CategoryWidgetState(String cat) {
    category = cat;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < Products.getProductsByCategory(category).length; i++) {
      isLoading.add(false);
      isLoadingForMinus.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Products.getProductsByCategory(category).isEmpty 
      ? Text(Dictionairy.words["category is empty"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),)
      : Container(
        color: Colors.white,
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: GridView.count(
          padding: EdgeInsets.only(
            top: theWidth < 600 ? theWidth * 0.05 : 30,
            bottom: 100,
            right: theWidth < 600 ? theWidth * 0.05 : 30,
            left: theWidth < 600 ? theWidth * 0.05 : 30,
          ),
          mainAxisSpacing: 5,
          crossAxisSpacing: theWidth < 600 ? theWidth * 0.05 : 30,
          crossAxisCount: 3,
          childAspectRatio: 0.54,
          children: <Widget>[
            for (var i = 0; i < Products.getProductsByCategory(category).length; i++)
              if(Products.getProductsByCategory(category)[i]["amount"] != 0)
              Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: 100,
                          height: 100,
                          child: FittedBox(
                            child: Text(
                              Basket.getQtyById(
                                Products.getProductsByCategory(category)[i]["ID"].toString(),
                              ),
                              style: TextStyle(
                                fontSize: 110,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(Products.getProductsByCategory(category)[i]["imageUrl"]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(theWidth < 600 ? theWidth * 0.05 : 35),
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
                      Positioned(
                        right: theWidth < 600 ? theWidth * 0.0225 : 15,
                        top: theWidth < 600 ? theWidth * 0.0225 : 15,
                        child: InkWell(
                          onTap: () {
                            if(isLoading[i] == false){  // to prevent the user from clicking while loading
                              if(Basket.simpleArray[Products.getProductsByCategory(category)[i]["ID"].toString()] == Products.getProductsByCategory(category)[i]["limit_amount_per_user"]){
                                Functions.showTheDialogue(context, "limit per user");
                                return;
                              }
                              setState(() {
                                isLoading[i] = true;
                              });
                              Basket.addItemToSimpleMap(Products.getProductsByCategory(category)[i]["ID"].toString());
                              http.post(env.apiUrl + "/api/takeproduct", body: {
                                "email": UserInformation.email, 
                                "sessionID": UserInformation.sessionID, 
                                "ID": Products.getProductsByCategory(category)[i]["ID"].toString(),
                                "basket": jsonEncode(Basket.simpleArray)
                              })
                              .then((value){
                                if(value.body.contains("error")){
                                  Functions.logout(context, Dictionairy.words[jsonDecode(value.body)["error"]][UserInformation.language], Colors.red);
                                  return;
                                }
                                if(jsonDecode(value.body)["msg"] == "product finished"){
                                  Basket.removeItemToSimpleMap(Products.getProductsByCategory(category)[i]["ID"].toString());
                                  setState(() {
                                    isLoading[i] = false;
                                  });
                                  Functions.showTheDialogue(context, "this product is out of stock");
                                  return;
                                }
                                Basket.addItem(Products.getProductsByCategory(category)[i]["ID"].toString(), Products.getProductsByCategory(category)[i]["Name"], Products.getProductsByCategory(category)[i]["size"], Products.getProductsByCategory(category)[i]["imageUrl"], Products.getProductsByCategory(category)[i]["price"].toString(), Products.getProductsByCategory(category)[i]["limit_amount_per_user"]);
                                setState(() {
                                  isLoading[i] = false;
                                });
                                widget.refresh();
                              });
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(theWidth < 600 ? theWidth * 0.035 : 20),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                              child: Container(
                                height: theWidth < 600 ? theWidth * 0.085 : 50,
                                width: theWidth < 600 ? theWidth * 0.085 : 50,
                                decoration: BoxDecoration(
                                  color: Colors.yellow[200].withOpacity(0.75),
                                ),
                                child: isLoading[i]
                                  ? Image.asset("assets/images/theLoading.gif", scale: 12,)
                                  : Icon(
                                  Icons.add,
                                  size: theWidth < 600 ? theWidth * 0.07 : 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: theWidth < 600 ? theWidth * 0.0225 : 15,
                        bottom: theWidth < 600 ? theWidth * 0.0225 : 15,
                        child: InkWell(
                          onTap: () {
                            if(isLoadingForMinus[i] == false && int.parse(Basket.getQtyById(Products.getProductsByCategory(category)[i]["ID"].toString())) != 0){ // to prevent the user from clicking while loading
                              setState(() {
                                isLoadingForMinus[i] = true;
                              });
                              Basket.removeItemToSimpleMap(Products.getProductsByCategory(category)[i]["ID"].toString());
                              http.post(env.apiUrl + "/api/leaveproduct", body: {
                                "email": UserInformation.email, 
                                "sessionID": UserInformation.sessionID, 
                                "ID": Products.getProductsByCategory(category)[i]["ID"].toString(),
                                "basket": jsonEncode(Basket.simpleArray)
                              })
                              .then((value){
                                if(value.body.contains("error")){
                                  Functions.logout(context, Dictionairy.words[jsonDecode(value.body)["error"]][UserInformation.language], Colors.red);
                                  return;
                                }
                                Basket.removeItem(Products.getProductsByCategory(category)[i]["ID"].toString());
                                setState(() {
                                  isLoadingForMinus[i] = false;
                                });
                                widget.refresh();
                              });
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(theWidth < 600 ? theWidth * 0.035 : 20),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                height: int.parse(Basket.getQtyById(Products.getProductsByCategory(category)[i]["ID"].toString(), forAnimation: true)) >= 1 ? theWidth < 600 ? theWidth * 0.085 : 50 : 0,
                                width: int.parse(Basket.getQtyById(Products.getProductsByCategory(category)[i]["ID"].toString(), forAnimation: true)) >= 1 ? theWidth < 600 ? theWidth * 0.085 : 50 : 0,
                                decoration: BoxDecoration(
                                  color: Colors.yellow[200].withOpacity(0.75),
                                ),
                                child: isLoadingForMinus[i]
                                  ? Image.asset("assets/images/theLoading.gif", scale: 12,)
                                  : Icon(
                                  Icons.remove,
                                  size: theWidth < 600 ? theWidth * 0.07 : 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(
                          bottom: theWidth < 600 ? theWidth * 0.035 : 2.5, 
                          left: theWidth < 600 ? theWidth * 0.035 : 2.5
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.75),
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: Text(
                          Products.getProductsByCategory(category)[i]["size"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: theWidth < 600 ? theWidth * 0.035 : 20,
                            color: Colors.black.withOpacity(0.75)
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 7.5,
                        left: 10,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(2.5, 2.5),
                                  color: Colors.black.withOpacity(0.1)
                                )
                              ]
                            ),
                            padding: EdgeInsets.all(2.5),
                            child: Text(
                              Products.getProductsByCategory(category)[i]["price"].toString() + "DT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: theWidth < 600 ? theWidth * 0.035 : 20,
                                color: Colors.black.withOpacity(0.85)
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              Products.getProductsByCategory(category)[i]["Name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: theWidth < 600 ? theWidth * 0.035 : 20,
                              ),
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
      ),
    );
  }
}
