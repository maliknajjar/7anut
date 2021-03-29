import 'dart:ui';

import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // adding it to an array so i can add the version number in the last
    List<Widget> arr = [Text("test")];
    arr.clear();
    for(int index = 0; index < titles.length; index++){
      arr.add(
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
                  Text(hintText[index], 
                    style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  titles[index] != "email" 
                  ? InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        "/editprofile", 
                        arguments: {
                          "type": titles[index], "title": hintText[index], "inputs": theInputs[index]
                        } 
                      )
                      .then((value){
                        setState(() {
                          refreshPrefs();
                        });
                      });
                    }, 
                    child: Text(Dictionairy.words["edit"][UserInformation.language], 
                    style: GoogleFonts.almarai(color: Colors.blue, fontSize: 20),)
                  ) 
                  : Text(""),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(stringArray[index], style: GoogleFonts.almarai(fontSize: 20, color: Colors.grey[600]),),
              )
            ],
          ),
        ),
      );
    }
    arr.add(
      Text(UserInformation.version + " + " + UserInformation.buildNumber, style: TextStyle(color: Colors.black.withOpacity(0.25)),),
    );

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
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 600
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              children: arr
            ),
          ),
        ),
      ),
    );
  }
}
