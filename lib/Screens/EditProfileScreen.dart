import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../env.dart';
import '../Classes/Functions.dart';
import '../Classes/Dictionairy.dart';

//ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  String editProfileTitle = "Edit";
  String editProfilePlaceHolder = "nothing";

  EditProfileScreen({String editProfileTitle, String editProfilePlaceHolder}) {
    this.editProfileTitle = editProfileTitle != null ? editProfileTitle : "Edit";
    this.editProfilePlaceHolder = editProfilePlaceHolder != null ? editProfileTitle : "Nothing";
  }

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  Widget button = Text(Dictionairy.words["Save"][UserInformation.language], style: GoogleFonts.almarai(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black.withOpacity(0.75)),);

  String translateInputs(String input){
    if (input == "new name") return Dictionairy.words["New Name"][UserInformation.language];
    else if (input == "new phone Number") return Dictionairy.words["New Phone Number"][UserInformation.language];
    else if (input == "old password") return Dictionairy.words["Old Password"][UserInformation.language];
    else if (input == "new password") return Dictionairy.words["New Password"][UserInformation.language];
  }

  @override
  Widget build(BuildContext context) {
    var theMap = (ModalRoute.of(context).settings.arguments as Map);
    var mapKeys = theMap["inputs"].keys.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          theMap["title"],
          style: GoogleFonts.almarai(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            height: double.infinity,
            padding: EdgeInsets.only(
              top: 25,
              left: 15,
              right: 15,
              bottom: 15
            ),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for(var index = 0; index < theMap["inputs"].length; index++)
                Column(
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
                            onChanged: (string){
                              theMap["inputs"][mapKeys[index]] = string;
                            },
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            obscureText: theMap["type"] == "password" ? true : false,
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              hintText: translateInputs(mapKeys[index]),
                              hintStyle: GoogleFonts.almarai()
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              // check if user's new password is week
              if (theMap["type"] == "password") {
                if(theMap["inputs"].values.toList()[1].length < 6){
                  // notify("your password is weak", 2000, Colors.red);
                  // Functions.alert(context, "Weak", "your password is weak");
                  showDialog(context: context, builder: (BuildContext context){
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.yellow[50],
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 300
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 40, top: 20),
                              child: Text(Dictionairy.words["your password is weak"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.1),
                                          Colors.black.withOpacity(0.025),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  });
                  return;
                }
              }
              for (var item in theMap["inputs"].values.toList()) {
                if(item == ""){
                  // Functions.alert(context, "input is empty", "you must fill all the fields");
                  showDialog(context: context, builder: (BuildContext context){
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.yellow[50],
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 300
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 40, top: 20),
                              child: Text(Dictionairy.words["Make sure to fill all the fields"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.1),
                                          Colors.black.withOpacity(0.025),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  });
                  return;
                }
              }
              // loading icon
              setState(() {
                button = Image.asset("assets/images/theLoading.gif", height: 30);   
              });
              SharedPreferences.getInstance().then((prefs){
                theMap["email"] = prefs.getString("email");
                theMap["sessionID"] = prefs.getString("sessionID");

                // send request
                http.post(env.apiUrl + "/api/editProfile", 
                headers: {
                  "content-type": "application/json",
                }, 
                body: json.encode(theMap))
                .then((value){
                  setState(() {
                    button = Text(Dictionairy.words["Save"][UserInformation.language], style: GoogleFonts.almarai(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black.withOpacity(0.75)),);
                  });
                  if(value.statusCode == 200){
                    if(json.decode(value.body)["error"] != null){
                      if(value.body.contains("session")){
                        Functions.logout(context, "Session is expired", Colors.red);
                        return;
                      } 
                      if (json.decode(value.body)["error"] == "this account was banned") {
                        Functions.logout(context, Dictionairy.words["this account was banned"][UserInformation.language], Colors.red);
                        return;
                      }
                      // Functions.alert(context, "error", json.decode(value.body)["error"]);
                      showDialog(context: context, builder: (BuildContext context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.yellow[50],
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 300
                            ),
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 40, top: 20),
                                  child: Text(Dictionairy.words[json.decode(value.body)["error"]] == null ? "null" : Dictionairy.words[json.decode(value.body)["error"]][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withOpacity(0.1),
                                              Colors.black.withOpacity(0.025),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow[100],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        );
                      });
                      return;
                    }
                    if(json.decode(value.body)["value"] != null){
                      prefs.setString(theMap["type"], json.decode(value.body)["value"]);
                    }
                    UserInformation();
                    Navigator.of(context).pop();
                  }
                })
                .catchError((onError){
                  Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
                });
              });
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.yellow[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ]
              ),
              padding: EdgeInsets.all(15),
              child: Center(
                child: button
              ),
            ),
          )
        ],
      ),
    );
  }
}
