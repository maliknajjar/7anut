import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        backgroundColor: Color(0xFF5DA7E6),
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            for(int index = 0; index < titles.length; index++)
            Container(
              decoration: BoxDecoration(
                // border: Border(
                //   bottom: BorderSide(
                //     color: Colors.grey.withOpacity(0.40),
                //     width: 1.5,
                //   )
                // ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 5)
                  )
                ]
              ),
              padding: EdgeInsets.only(bottom: 30, top: 15, left: 15, right: 15, ),
              margin: EdgeInsets.only(top: 0, bottom: 25, left: 0, right: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titles[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      titles[index] != "email" ? InkWell(onTap: (){Navigator.of(context).pushNamed("/editprofile", arguments: {"type": titles[index], "title": "Edit " + titles[index], "inputs": theInputs[index]} ).then((value){setState(() {refreshPrefs();});});}, child: Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 20),)) : Text(""),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(stringArray[index], style: TextStyle(fontSize: 20, color: Colors.grey[600]),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
