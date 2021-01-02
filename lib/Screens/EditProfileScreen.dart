import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configuration.dart';
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

  @override
  Widget build(BuildContext context) {
    var theMap = (ModalRoute.of(context).settings.arguments as Map);
    var mapKeys = theMap["inputs"].keys.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5DA7E6),
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
            padding: EdgeInsets.all(15),
            height: double.infinity,
            color: Colors.white.withOpacity(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for(var index = 0; index < theMap["inputs"].length; index++)
                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7.5,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
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
                      hintText: mapKeys[index]),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              for (var item in theMap["inputs"].values.toList()) {
                if(item == ""){
                  print("input is empty");
                  Functions.alert(context, "input is empty", "you must fill all the fields");
                  return;
                }
              }
              SharedPreferences.getInstance().then((prefs){
                theMap["email"] = prefs.getString("email");
                theMap["sessionID"] = prefs.getString("sessionID");

                // send request
                http.post(Configuration.url + "/api/editProfile", 
                headers: {
                  "content-type": "application/json",
                }, 
                body: json.encode(theMap))
                .then((value){
                  if(json.decode(value.body)["error"] != null){
                    if(value.body.contains("session")){
                      Functions.logout(context);
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
                });
              });
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue, 
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text("Save", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
