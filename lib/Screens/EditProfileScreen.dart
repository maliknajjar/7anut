import 'package:flutter/material.dart';

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
    var mapValues = theMap["placeholder"].values.toList();
    var mapKeys = theMap["placeholder"].keys.toList();

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
                for(var index = 0; index < theMap["placeholder"].length; index++)
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
                      mapValues[index] = string;
                    },
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: theMap["placeholder"].keys.toList()[index]),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              print("save pressed");
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
