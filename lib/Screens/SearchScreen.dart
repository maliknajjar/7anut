import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Procucts.dart';
import '../Classes/Basket.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Functions.dart';
import '../env.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm;
  List<bool> isLoading = [];
  List<bool> isLoadingForMinus = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        centerTitle: true,
        title: Text(
          Dictionairy.words["Search"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        backgroundColor: Colors.yellow[200],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(5, 5)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow[50],
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 5,
                          color: Colors.white,
                          offset: Offset(10, 10)
                        ),
                        BoxShadow(
                          spreadRadius: -5,
                          blurRadius: 20,
                          color: Colors.yellow[100],
                          offset: Offset(-5, -2.5)
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextField(
                      onSubmitted: (string){
                        isLoading.clear();
                        isLoadingForMinus.clear();
                        for (var i = 0; i < Products.searchProductsByName(string).length; i++) {
                          isLoading.add(false);
                          isLoadingForMinus.add(false);
                        }
                        setState(() {
                          if (string == ""){
                            searchTerm = null;
                            return;
                          }
                          searchTerm = string;                  
                        });
                      },
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: Dictionairy.words["Search"][UserInformation.language],
                        hintStyle: GoogleFonts.almarai()
                      ),
                    ),
                  ),
                ),
              ),
              searchTerm == null 
              ? Container(
                height: MediaQuery.of(context).size.height - 200, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(Dictionairy.words["Search"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 40, color: Colors.black.withOpacity(0.25)),),
                    Icon(Icons.search, size: 40, color: Colors.black.withOpacity(0.25)),
                  ],
                ),
              )
              : Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  child: Products.searchProductsByName(searchTerm).contains("no results")
                  ? Container(
                      padding: EdgeInsets.all(15),
                      child: Text("No Results", style: GoogleFonts.almarai(fontSize: 22),),
                    )
                  : Column(
                    children: [
                      for (var i = 0; i < Products.searchProductsByName(searchTerm).length; i++)
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.yellow[50],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(Products.searchProductsByName(searchTerm)[i]["imageUrl"]),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7.5,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(2.5, 2.5),
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: FittedBox(
                                child: Text(
                                  Basket.getQtyById(
                                    Products.searchProductsByName(searchTerm)[i]["ID"].toString(),
                                  ),
                                  style: GoogleFonts.almarai(
                                    fontSize: 110,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.75),
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withOpacity(0.75),
                                        blurRadius: 15
                                      )
                                    ]
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Container(
                                height: 80,
                                margin: EdgeInsets.only(left: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(Products.searchProductsByName(searchTerm)[i]["Name"], style: GoogleFonts.almarai(fontSize: 16),),
                                    Text(Products.searchProductsByName(searchTerm)[i]["price"].toString() + " DT", style: GoogleFonts.almarai(fontSize: 16, color: Colors.black.withOpacity(0.5)),),
                                    Text(Products.searchProductsByName(searchTerm)[i]["size"].toString(), style: GoogleFonts.almarai(fontSize: 16, color: Colors.black.withOpacity(0.5)),),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              margin: EdgeInsets.only(right: 7.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      // setState(() {
                                      //   Basket.addItem(Products.searchProductsByName(searchTerm)[i]["ID"].toString(), Products.searchProductsByName(searchTerm)[i]["Name"], Products.searchProductsByName(searchTerm)[i]["size"], Products.searchProductsByName(searchTerm)[i]["imageUrl"], Products.searchProductsByName(searchTerm)[i]["price"].toString(), Products.searchProductsByName(searchTerm)[i]["limit_amount_per_user"]);
                                      // });
                                      if(isLoading[i] == false){  // to prevent the user from clicking while loading
                                        setState(() {
                                          isLoading[i] = true;
                                        });
                                        http.post(env.apiUrl + "/api/takeproduct", body: {
                                          "email": UserInformation.email, 
                                          "sessionID": UserInformation.sessionID, 
                                          "ID": Products.searchProductsByName(searchTerm)[i]["ID"].toString(),
                                          "basket": jsonEncode(Basket.addToSimpleFuture(Products.searchProductsByName(searchTerm)[i]["ID"].toString()))
                                        })
                                        .then((value){
                                          if(value.body.contains("error")){
                                            print(value.body);
                                            Functions.logout(context, Dictionairy.words[jsonDecode(value.body)["error"]][UserInformation.language], Colors.red);
                                            return;
                                          }
                                          // cancel every thing if limit is reached
                                          print(value.body);
                                          if(jsonDecode(value.body)["msg"] == "reached limit"){
                                            Functions.showTheDialogue(context, "limit per user");
                                            setState(() {
                                              isLoading[i] = false;
                                            });
                                            return;
                                          }
                                          if(jsonDecode(value.body)["msg"] == "product finished"){
                                            setState(() {
                                              isLoading[i] = false;
                                            });
                                            Functions.showTheDialogue(context, "this product is out of stock");
                                            return;
                                          }
                                          Basket.addItem(Products.searchProductsByName(searchTerm)[i]["ID"].toString(), Products.searchProductsByName(searchTerm)[i]["Name"], Products.searchProductsByName(searchTerm)[i]["size"], Products.searchProductsByName(searchTerm)[i]["imageUrl"], Products.searchProductsByName(searchTerm)[i]["price"].toString(), Products.searchProductsByName(searchTerm)[i]["limit_amount_per_user"]);
                                          setState(() {
                                            isLoading[i] = false;
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 7.5,
                                            spreadRadius: 1,
                                            color: Colors.black.withOpacity(0.25),
                                            offset: Offset(2.5, 2.5),
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: isLoading[i]
                                        ? Image.asset("assets/images/theLoading.gif", scale: width < 600 ? width * 0.025 : 8,)
                                        : Icon(
                                          Icons.add,
                                          size: width < 600 ? width * 0.07 : 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      // setState(() {
                                      //   Basket.removeItem(Products.searchProductsByName(searchTerm)[i]["ID"].toString());
                                      // });
                                      if(isLoadingForMinus[i] == false && int.parse(Basket.getQtyById(Products.searchProductsByName(searchTerm)[i]["ID"].toString())) != 0){ // to prevent the user from clicking while loading
                                        setState(() {
                                          isLoadingForMinus[i] = true;
                                        });
                                        http.post(env.apiUrl + "/api/leaveproduct", body: {
                                          "email": UserInformation.email, 
                                          "sessionID": UserInformation.sessionID, 
                                          "ID": Products.searchProductsByName(searchTerm)[i]["ID"].toString(),
                                          "basket": jsonEncode(Basket.removeFromSimpleFuture(Products.searchProductsByName(searchTerm)[i]["ID"].toString()))
                                        })
                                        .then((value){
                                          print(value.body);
                                          if(value.body.contains("error")){
                                            Functions.logout(context, Dictionairy.words[jsonDecode(value.body)["error"]][UserInformation.language], Colors.red);
                                            return;
                                          }
                                          Basket.removeItem(Products.searchProductsByName(searchTerm)[i]["ID"].toString());
                                          setState(() {
                                            isLoadingForMinus[i] = false;
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 7.5,
                                            spreadRadius: 1,
                                            color: Colors.black.withOpacity(0.25),
                                            offset: Offset(2.5, 2.5),
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: isLoadingForMinus[i]
                                        ? Image.asset("assets/images/theLoading.gif", scale: width < 600 ? width * 0.025 : 8,)
                                        : Icon(Icons.remove, size: width < 600 ? width * 0.07 : 40,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}