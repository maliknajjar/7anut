import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Dictionairy.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> hintText = [ Dictionairy.words["Email"][UserInformation.language], Dictionairy.words["Full Name"][UserInformation.language], Dictionairy.words["Phone Number"][UserInformation.language], Dictionairy.words["Password"][UserInformation.language]];
  List<String> titles = ["email", "full name", "phone number", "password"];
  var theInputs = [{}, {"new name": ""}, {"new phone Number": ""}, {"old password": "", "new password": ""}];
  List<String> stringArray = ["", "", "", "************"];

  @override
  void initState() {
    super.initState();
    refreshPrefs();
  }

  void refreshPrefs(){  
    SharedPreferences.getInstance().then((prefs){
      setState(() {
        stringArray[0] = prefs.getString("email");
        stringArray[1] = prefs.getString("full name");
        stringArray[2] = prefs.getString("phone number");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          Dictionairy.words["Profile"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.5,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(2.5, 2.5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.yellow[50],
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Dictionairy.words["Language"][UserInformation.language], style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 20),),
                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (context){
                                return StatefulBuilder(
                                  builder: (context, setState){
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.yellow[100],
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        SharedPreferences.getInstance().then((value){
                                                          value.setString("language", "ar").then((theValue){
                                                            UserInformation();    // refresh the UserInformation class
                                                            Navigator.of(context).pop();
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: 10
                                                        ),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: Colors.yellow[50],
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors.yellow[50],
                                                              Colors.yellow[100],
                                                            ],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 5,
                                                              spreadRadius: 1,
                                                              color: Colors.black.withOpacity(0.2),
                                                              offset: Offset(2.5, 2.5),
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        padding: EdgeInsets.all(15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("عربي", style: GoogleFonts.almarai(fontSize: 20),),
                                                            Icon(Icons.language_outlined),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        SharedPreferences.getInstance().then((value){
                                                          value.setString("language", "en").then((theValue){
                                                            UserInformation();    // refresh the UserInformation class
                                                            Navigator.of(context).pop();
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: 10
                                                        ),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: Colors.yellow[50],
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors.yellow[50],
                                                              Colors.yellow[100],
                                                            ],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 5,
                                                              spreadRadius: 1,
                                                              color: Colors.black.withOpacity(0.2),
                                                              offset: Offset(2.5, 2.5),
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        padding: EdgeInsets.all(15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("English", style: GoogleFonts.almarai(fontSize: 20),),
                                                            Icon(Icons.language_outlined),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        SharedPreferences.getInstance().then((value){
                                                          value.setString("language", "fr").then((theValue){
                                                            UserInformation();    // refresh the UserInformation class
                                                            Navigator.of(context).pop();
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: 10
                                                        ),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: Colors.yellow[50],
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors.yellow[50],
                                                              Colors.yellow[100],
                                                            ],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 5,
                                                              spreadRadius: 1,
                                                              color: Colors.black.withOpacity(0.2),
                                                              offset: Offset(2.5, 2.5),
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        padding: EdgeInsets.all(15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Français", style: GoogleFonts.almarai(fontSize: 20),),
                                                            Icon(Icons.language_outlined),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  }
                                );
                              }
                            ).then((value){
                              setState((){
                                hintText = [Dictionairy.words["Email"][UserInformation.language], Dictionairy.words["Full Name"][UserInformation.language], Dictionairy.words["Phone Number"][UserInformation.language], Dictionairy.words["Password"][UserInformation.language]];
                              });
                            });
                          },
                          child: Text(Dictionairy.words["edit"][UserInformation.language], style: GoogleFonts.almarai(color: Colors.blue, fontSize: 20),),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(UserInformation.language == "en" ? "English" : UserInformation.language == "fr" ? "Français" : "عربي", style: GoogleFonts.almarai(fontSize: 20, color: Colors.grey[600]),),
                    )
                  ],
                ),
              ),
              for(int index = 0; index < titles.length; index++)
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.5,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(2.5, 2.5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.yellow[50],
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(hintText[index], style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 20),),
                        titles[index] != "email" ? InkWell(onTap: (){Navigator.of(context).pushNamed("/editprofile", arguments: {"type": titles[index], "title": hintText[index], "inputs": theInputs[index]} ).then((value){setState(() {refreshPrefs();});});}, child: Text(Dictionairy.words["edit"][UserInformation.language], style: GoogleFonts.almarai(color: Colors.blue, fontSize: 20),)) : Text(""),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(stringArray[index], style: GoogleFonts.almarai(fontSize: 20, color: Colors.grey[600]),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
