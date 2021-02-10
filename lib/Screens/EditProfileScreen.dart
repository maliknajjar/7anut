import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:password_strength/password_strength.dart';

import '../env.dart';
import '../Classes/Functions.dart';

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

  Widget button = Text("Save", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black.withOpacity(0.75)),);

  String translateInputs(String input){
    if (input == "new name") return "New Name";
    else if (input == "new phone Number") return "New Phone Number";
    else if (input == "old password") return "Old Password";
    else if (input == "new password") return "New Password";
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
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
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
                            blurRadius: 40,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.1),
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
                                offset: Offset(0, 0)
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
                if(estimatePasswordStrength(theMap["inputs"].values.toList()[1]) < 0.3){
                  // notify("your password is weak", 2000, Colors.red);
                  Functions.alert(context, "Weak", "your password is weak");
                  return;
                }
              }
              for (var item in theMap["inputs"].values.toList()) {
                if(item == ""){
                  print("input is empty");
                  Functions.alert(context, "input is empty", "you must fill all the fields");
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
                    button = Text("Save", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black.withOpacity(0.75)),);
                  });
                  if(value.statusCode == 200){
                    if(json.decode(value.body)["error"] != null){
                      if(value.body.contains("session")){
                        Functions.logout(context, "Session is expired", Colors.red);
                        return;
                      }
                      Functions.alert(context, "error", json.decode(value.body)["error"]);
                      return;
                    }
                    if(json.decode(value.body)["value"] != null){
                      prefs.setString(theMap["type"], json.decode(value.body)["value"]);
                      print("string was changed");
                    }
                    print(value.body);
                    Navigator.of(context).pop();
                  }
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
