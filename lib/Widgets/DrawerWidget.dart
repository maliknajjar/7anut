import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Functions.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.yellow[100],
              Colors.yellow[50],
            ]
          )
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow[100],
                        Colors.yellow[50],
                      ]
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7.5,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(2.5, 2.5),
                      )
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7.5,
                                spreadRadius: 1,
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(2.5, 2.5),
                              ),
                            ],
                          ),
                          child: Text(UserInformation.fullName.substring(0, 1), style: GoogleFonts.almarai(fontSize: 50)),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 10
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 182.5,
                                child: Text(UserInformation.fullName, style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),), overflow: TextOverflow.fade, maxLines: 2, softWrap: true,),
                              ),
                              Text(UserInformation.email, style: GoogleFonts.almarai(),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.25),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 15,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed("/profile");
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.person_outline, size: 32, color: Colors.black.withOpacity(0.75),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(Dictionairy.words["Profile"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 25,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed("/search");
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.search, size: 32, color: Colors.black.withOpacity(0.75),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(Dictionairy.words["Search"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 25,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed("/basket");
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.shopping_cart_outlined, size: 32, color: Colors.black.withOpacity(0.75),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(Dictionairy.words["Basket"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 25,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed("/adresses");
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, size: 32, color: Colors.black.withOpacity(0.75),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(Dictionairy.words["Addresses"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 25,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed("/orders");
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, size: 32, color: Colors.black.withOpacity(0.75),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(Dictionairy.words["Orders"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 25,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed("/language", arguments: {"pop"});
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.language_outlined, size: 32, color: Colors.black.withOpacity(0.75),),
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      child: Text(Dictionairy.words["Language"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Functions.logout(context, null, null);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 32, color: Colors.black.withOpacity(0.75),),
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: Text(Dictionairy.words["Sign Out"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75),),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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