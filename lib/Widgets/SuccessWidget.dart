import '../Classes/Basket.dart';
import '../Classes/Dictionairy.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.green[50], Colors.green[200]],
            radius: 0.75
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.green[100],
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7.5,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(2.5, 2.5),
                  )
                ],
                shape: BoxShape.circle
                // borderRadius: BorderRadius.circular(15)
              ),
              child: Icon(Icons.done_outline, size: 100, color: Colors.black.withOpacity(0.5),),
            ),
            GestureDetector(
              onTap: (){
                Basket.clearBasket();
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                Navigator.of(context).pushNamed("/orders");
              },
              child: Container(
                width: 240,
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20,),
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.5,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(2.5, 2.5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Dictionairy.words["Go to Orders Page"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, color: Colors.black.withOpacity(0.75)),),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Basket.clearBasket();
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(Dictionairy.words["Go to Home Screen"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, color: Colors.black.withOpacity(0.75)),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}