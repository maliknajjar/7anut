import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';

class LoginScreen extends StatefulWidget {
  String message;
  Color theColor;
  LoginScreen({this.message, this.theColor});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  Widget theButton = Text(Dictionairy.words["Sign In"][UserInformation.language], style: TextStyle(fontSize: 18),);
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
                          constraints: BoxConstraints(maxWidth: 300),
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
                                margin: EdgeInsets.only(
                                  bottom: 10, 
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.05),
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
                                      onChanged: (string){
                                        email = string;
                                      },
                                      style: TextStyle(fontSize: 15),
                                      cursorColor: Colors.black54,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                                        hintText: Dictionairy.words["Email"][UserInformation.language]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.05),
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
                                      onChanged: (string){
                                        password = string;
                                      },
                                      obscureText: true,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                      cursorColor: Colors.black54,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                                        hintText: Dictionairy.words["Password"][UserInformation.language]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  if(email == "" || password == ""){
                                    notify(Dictionairy.words["fields are not filled"][UserInformation.language], 2000, Colors.red);
                                    return;
                                  }
                                  setState(() {
                                    theButton = Image.asset("assets/images/theLoading.gif", height: 30);
                                  });
                                  http.post(env.apiUrl + "/api/signin", body: {
                                    "email": email,
                                    "password": password,
                                  }).then((result){
                                    theButton = Text(Dictionairy.words["Sign In"][UserInformation.language], style: TextStyle(fontSize: 18),);
                                    var response = json.decode(result.body);
                                    if(response["error"] != null){
                                      print(response["error"].toString());
                                      notify(response["error"].toString(), 2000, Colors.red);
                                      return;
                                    }
                                    // saving these information when everything is successful
                                    SharedPreferences.getInstance().then((value){
                                      value.setString("email", email).then((theValue){
                                        print("email saved: " + response["email"]);
                                        value.setString("sessionID", response["session"]).then((anotherValue){
                                          print("sessionID saved: " + response["session"]);
                                          value.setString("full name", response["fullName"]).then((anotherValue){
                                            print("full name saved: " + response["fullName"]);
                                            value.setString("phone number", response["phoneNumber"]).then((anotherValue){
                                              print("phone number saved: " + response["phoneNumber"]);
                                              UserInformation();  // saving logged in user information
                                              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                                            });
                                          });
                                        });
                                      });
                                    });
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 25),
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50)
                                    ),
                                  ),
                                  child: Center(
                                    child: theButton,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 300),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 2,
                                  margin: EdgeInsets.only(left: 20, top: 30, bottom: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(child: Text(Dictionairy.words["or"][UserInformation.language])),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 2,
                                  margin: EdgeInsets.only(right: 20, top: 30, bottom: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(maxWidth: 300),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed("/register");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                child: Text(Dictionairy.words["Create New Account"][UserInformation.language]),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed("/forgotpassword").then((value){
                              if(value == null) return;
                              notify(value, 2000, Colors.green);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(bottom: 75),
                            child: Text(Dictionairy.words["Forget Password ?"][UserInformation.language], style: TextStyle(color: Colors.black.withOpacity(0.75), decoration: TextDecoration.underline)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed("/language");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.5,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(2.5, 2.5),
                    ),
                    BoxShadow(
                      color: Colors.yellow[50],
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Text(Dictionairy.words["choose a language"][UserInformation.language], style: TextStyle(fontSize: 16),),
                    Container(child: Icon(Icons.language_outlined), margin: EdgeInsets.only(left: 10),)
                  ],
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
