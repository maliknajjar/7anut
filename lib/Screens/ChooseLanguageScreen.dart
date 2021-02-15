import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../Classes/UserInformation.dart';

class ChooseLanguageScreen extends StatefulWidget {
  String message;
  Color theColor;
  ChooseLanguageScreen({this.message, this.theColor});
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  String notificationMessage = "no message";
  double notificationPlace = -60;
  Color notificationColor = Colors.red;
  void notify(String msg, int timer, Color color){
    setState(() {
      notificationMessage = msg;
      notificationPlace = 20;
      notificationColor = color;
      Timer(Duration(milliseconds: timer), (){
        setState(() {
          notificationPlace = -60;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.message != null){
      notify(widget.message, 3000, widget.theColor);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.white,
                  Colors.yellow[50],
                ],
                stops: [0.0, 1.0],
                radius: 1,
                tileMode: TileMode.clamp
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.yellow[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(15)
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7.5,
                                spreadRadius: 1,
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(2.5, 2.5),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 25, bottom: 25),
                                child: Image.asset(
                                  "assets/images/logo-01.png",
                                  height: 35,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  border: Border.all(width: 2, color: Colors.black.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Text("اختر لغتك"),
                                    Text("Select your Language"),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text("Choisissez votre langue"),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  SharedPreferences.getInstance().then((value){
                                    value.setString("language", "ar").then((theValue){
                                      UserInformation();    // refresh the UserInformation class
                                      Navigator.of(context).pushNamed("/login");
                                    });
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[50],
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("عربي", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      Container(child: Icon(Icons.language_outlined, color: Colors.black.withOpacity(0.5)), margin: EdgeInsets.only(left: 10),)
                                    ],
                                  )
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  SharedPreferences.getInstance().then((value){
                                    value.setString("language", "en").then((theValue){
                                      UserInformation();    // refresh the UserInformation class
                                      Navigator.of(context).pushNamed("/login");
                                    });
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[50],
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("English", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      Container(child: Icon(Icons.language_outlined, color: Colors.black.withOpacity(0.5)), margin: EdgeInsets.only(left: 10),)
                                    ],
                                  )
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  SharedPreferences.getInstance().then((value){
                                    value.setString("language", "fr").then((theValue){
                                      UserInformation();    // refresh the UserInformation class
                                      Navigator.of(context).pushNamed("/login");
                                    });
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[50],
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Français", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      Container(child: Icon(Icons.language_outlined, color: Colors.black.withOpacity(0.5),), margin: EdgeInsets.only(left: 10),)
                                    ],
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: notificationPlace,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: notificationColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7.5,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(2.5, 2.5),
                  )
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(notificationMessage, style: TextStyle(fontSize: 20, color: Colors.white),)
              ),
            ), 
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
        ],
      ),
    );
  }
}
