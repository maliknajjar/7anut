import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:password_strength/password_strength.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String registerButtonName = "Register";

  String email = "";
  String fullName = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF5DA7E6).withOpacity(0.75),
                  Color(0xFF3C9DE5),
                ],
                stops: [0.0, 1.0],
                radius: 1,
                tileMode: TileMode.clamp,
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
                            color: Colors.yellow,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15)
                            ),
                            boxShadow: [
                                BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 3,
                                color: Colors.grey[800].withOpacity(0.5)
                              ),
                            ]
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
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                      BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.1)
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFFCE1),
                                      Color(0xFFFFF6A4),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
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
                                    hintText: 'Email'
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 7.5,),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                      BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.1)
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFFCE1),
                                      Color(0xFFFFF6A4),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
                                  ), 
                                ),
                                child: TextField(
                                  onChanged: (string){
                                    fullName = string;
                                  },
                                  style: TextStyle(fontSize: 15),
                                  cursorColor: Colors.black54,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    hintText: 'Full Name'
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    margin: EdgeInsets.only(top: 7.5, right: 7.5),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                          BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          color: Colors.black.withOpacity(0.1)
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFFCE1),
                                          Color(0xFFFFF6A4),
                                        ],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(0.0, 1.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp
                                      ), 
                                    ),
                                    child: Center(child: Text("+216"))
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 7.5,),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                            BoxShadow(
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                            color: Colors.black.withOpacity(0.1)
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFFCE1),
                                            Color(0xFFFFF6A4),
                                          ],
                                          begin: FractionalOffset(0.0, 0.0),
                                          end: FractionalOffset(0.0, 1.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp
                                        ), 
                                      ),
                                      child: TextField(
                                        onChanged: (string){
                                          phoneNumber = string;
                                        },
                                        style: TextStyle(fontSize: 15),
                                        cursorColor: Colors.black54,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                                          hintText: 'Phone Number'
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 7.5,),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                      BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.1)
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFFCE1),
                                      Color(0xFFFFF6A4),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
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
                                    hintText: 'Password'
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 7.5,
                                  bottom: 20, 
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                      BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.1)
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFFCE1),
                                      Color(0xFFFFF6A4),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (string){
                                    confirmPassword = string;
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
                                    hintText: 'Confirm Password'
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  // adding loading icon or text to the Register button when its pressed
                                  setState(() {
                                    registerButtonName = "Loading";
                                  });
                                  // check if any of the fields is empty
                                  if(email == "" || fullName == "" || phoneNumber == "" || password == "" || confirmPassword == ""){
                                    notify("You need to fill all fields", 2000, Colors.red);
                                    return;
                                  }
                                  // check if the password is strong enough
                                  if(estimatePasswordStrength(password) < 0.3){
                                    notify("your password is weak", 2000, Colors.red);
                                    return;
                                  }
                                  //check if the paswords are not similar
                                  if(password != confirmPassword){
                                    notify("Password does not match", 2000, Colors.red);
                                    return;
                                  }
                                  // making the request to the server to create a new user
                                  http.post("http://10.0.2.2:8000/api/createUser", body: {
                                    "email": email,
                                    "fullName": fullName,
                                    "phoneNumber": phoneNumber,
                                    "password": password,
                                  }).then((result){
                                    var response = json.decode(result.body);
                                    setState(() {
                                      registerButtonName = "Register";
                                    });
                                    if(response["error"] != null){
                                      notify(response["error"], 2000, Colors.red);
                                      return;
                                    }
                                    // when everything is successful
                                    SharedPreferences.getInstance().then((value){
                                      value.setString("email", email).then((theValue){
                                        print("email saved");
                                        value.setString("sessionID", response["session"]).then((anotherValue){
                                          print("sessionID saved: " + response["session"]);
                                          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                                        });
                                      });
                                    });
                                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                        BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                        color: Colors.black.withOpacity(0.25)
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15)
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.yellow[300],
                                        Colors.yellow,
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(0.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp
                                    ), 
                                  ),
                                  child: Center(
                                    child: Text(registerButtonName),
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
                                  child: Center(child: Text("or")),
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
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 150),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[400],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15)
                                  ),
                                  boxShadow: [
                                      BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                      color: Colors.grey[800].withOpacity(0.5)
                                    ),
                                  ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text("Go Back"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                border: Border.all(color: Colors.black.withOpacity(0.3), width: 2.5)
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
