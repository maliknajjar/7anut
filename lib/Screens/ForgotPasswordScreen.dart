import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFF5DA7E6).withOpacity(0.75),
              Color(0xFF3C9DE5),
            ],
            stops: [0.0, 1.0],
            radius: 1,
            tileMode: TileMode.clamp
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 300),
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 25),
                      child: Image.asset(
                        "assets/images/logo-01.png",
                        height: 35,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 7.5,
                        bottom: 20, 
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                            BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.1)
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
                          hintText: 'Email'
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        print("this works");
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                              BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 3,
                              color: Colors.black.withOpacity(0.25)
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(15)
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow[300],
                              Colors.yellow,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp
                          ), 
                        ),
                        child: Center(
                          child: Text("Send New Password"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 300),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 2,
                        margin: EdgeInsets.only(left: 20, top: 30, bottom: 30),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(child: Text("or")),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 2,
                        margin: EdgeInsets.only(right: 20, top: 30, bottom: 30),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 300),
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      print("this works");
                    },
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 150),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.yellow[400],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Go Back"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}