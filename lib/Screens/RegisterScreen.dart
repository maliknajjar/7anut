import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:password_strength/password_strength.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';
import '../Classes/UserInformation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Widget registerButtonName = Text("Register", style: TextStyle(fontSize: 18),);

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
                  Colors.white,
                  Colors.yellow[50],
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
                                        hintText: 'Email'
                                      ),
                                    ),
                                  ),
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
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 10, 
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10, 
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
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                          child: Center(child: Text("+216"))
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
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
                                      ),
                                    ),
                                  ],
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
                                ),
                              ),
                              InkWell(
                                onTap: (){
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
                                  // adding loading icon or text to the Register button when its pressed
                                  setState(() {
                                    registerButtonName = Image.asset("assets/images/theLoading.gif", height: 30);
                                  });
                                  // making the request to the server to create a new user
                                  http.post(env.apiUrl + "/api/createUser", body: {
                                    "email": email,
                                    "fullName": fullName,
                                    "phoneNumber": phoneNumber,
                                    "password": password,
                                  }).then((result){
                                    var response = json.decode(result.body);
                                    setState(() {
                                      registerButtonName = Text("Register", style: TextStyle(fontSize: 18),);
                                    });
                                    if(response["error"] != null){
                                      notify(response["error"], 2000, Colors.red);
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
                                    child: registerButtonName,
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
                                  color: Colors.yellow[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100)
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
