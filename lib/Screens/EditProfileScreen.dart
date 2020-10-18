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
  bool isSelected = false;

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
          widget.editProfileTitle,
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          print("clicked global");
          setState(() {
            isSelected = false;
          });
        },
        child: Container(
          padding: EdgeInsets.all(15),
          height: double.infinity,
          color: Colors.white.withOpacity(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 7.5,
                    bottom: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        isSelected = true;
                      });
                      print("clicked input");
                    },
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: widget.editProfilePlaceHolder),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  print("save pressed");
                },
                child: Container(
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
        ),
      ),
    );
  }
}
