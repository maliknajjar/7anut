import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
                      Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 20),),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("Malik Hammad Ben Abdennabi", style: TextStyle(fontSize: 20, color: Colors.grey[600]),),
                  )
                ],
              ),
            ),
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
                      Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 20),),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("Malik446644@gmail.com", style: TextStyle(fontSize: 20, color: Colors.grey[600]),),
                  )
                ],
              ),
            ),
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
                      Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 20),),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("21623333407", style: TextStyle(fontSize: 20, color: Colors.grey[600]),),
                  )
                ],
              ),
            ),
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
                      Text("Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 20),),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("*****************", style: TextStyle(fontSize: 20, color: Colors.grey[600]),),
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
