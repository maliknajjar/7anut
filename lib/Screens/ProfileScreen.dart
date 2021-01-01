import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> titles = ["name", "phone number", "password"];
  var theInputs = [{"new name": ""}, {"new phone Number": ""}, {"old password": "", "new password": "", "retype new password": ""}];
  List<String> stringArray = ["", "", "************"];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs){
      setState(() {
        stringArray[0] = prefs.getString("fullName");
        stringArray[1] = prefs.getString("phoneNumber");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.40),
                    width: 2,
                  )
                )
              ),
              padding: EdgeInsets.only(bottom: 15),
              margin: EdgeInsets.only(top: 0, bottom: 15, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titles[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      InkWell(onTap: (){Navigator.of(context).pushNamed("/editprofile", arguments: {"type": titles[index], "title": "Edit " + titles[index], "inputs": theInputs[index]} );}, child: Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 20),)),
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
