import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';

import '../env.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/Functions.dart';

import './PinScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = "";
  Widget theButton = Container(margin: EdgeInsets.all(10), child: Text(Dictionairy.words["Change Password"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18)),);
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
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                      cursorColor: Colors.black54,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                                        hintText: Dictionairy.words["Email"][UserInformation.language],
                                        hintStyle: UserInformation.language == "ar" ? GoogleFonts.almarai(fontSize: 18) : GoogleFonts.roboto(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  if(email == ""){
                                    notify(Dictionairy.words["fields are not filled"][UserInformation.language], 2000, Colors.red);
                                    return;
                                  }
                                  setState(() {
                                    theButton = Container(margin: EdgeInsets.all(5), child: Image.asset("assets/images/theLoading.gif", height: 30));
                                  });
                                  http.post(env.apiUrl + "/api/forgetpassword", body: {
                                    "email": email,
                                  }).then((result){
                                    setState(() {
                                      theButton = Container(margin: EdgeInsets.all(10), child: Text(Dictionairy.words["Change Password"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18)),);
                                    });
                                    var response = json.decode(result.body);
                                    if(response["error"] != null){
                                      if(response["error"] == "email does not exist"){
                                        notify(Dictionairy.words["email does not exist"][UserInformation.language], 2000, Colors.red);
                                        return;
                                      }
                                      notify(response["error"], 2000, Colors.red);
                                      return;
                                    }
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PinScreen(email)));
                                  })
                                  .catchError((onError){
                                    Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 25),
                                  width: double.infinity,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.5,
                                        spreadRadius: 1,
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(2.5, 2.5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100)
                                    ),
                                    color: Colors.yellow[100],
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
                                  child: Center(child: Text(Dictionairy.words["or"][UserInformation.language], style: UserInformation.language == "ar" ? GoogleFonts.almarai() : GoogleFonts.roboto(),)),
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
                                      child: Text(Dictionairy.words["Go Back"][UserInformation.language], style: UserInformation.language == "ar" ? GoogleFonts.almarai() : GoogleFonts.roboto(),),
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                child: Text(notificationMessage, style: GoogleFonts.almarai(fontSize: 18, color: Colors.white))
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