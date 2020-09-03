import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.blue[400],
              gradient: RadialGradient(
                colors: [
                  Color(0xFF5DA7E6).withOpacity(0.75),
                  Color(0xFF3C9DE5),
                ],
                // begin: FractionalOffset(0.0, 0.0),
                // end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                radius: 1,
                tileMode: TileMode.clamp
              ),
            ),
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 300),
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(
                  Radius.circular(15)
                ),
                boxShadow: [
                    BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 3,
                    color: Colors.grey[800].withOpacity(0.5)
                  ),
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo-01.png",
                    height: 35,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 25
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                          BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.25)
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFFCE1),
                          Color(0xFFFFF6A4),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp
                      ), 
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 15),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Email'
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                          BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.25)
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFFCE1),
                          Color(0xFFFFF6A4),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp
                      ),
                    ),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Password'
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ], 
      ),
    );
  }
}
