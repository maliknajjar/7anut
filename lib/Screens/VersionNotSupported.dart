import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VersionNotSupported extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.yellow[50],
              Colors.yellow[100],
            ]
          )
        ),
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Text("😭", style: TextStyle(fontSize: 100),),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text("إصدار التطبيق قديم وغير مدعوم ، تحتاج إلى تحديث تطبيقك",
                textAlign: TextAlign.center,
                style: GoogleFonts.almarai(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text("App's version is old and not supported, you need update your app",
                textAlign: TextAlign.center,
                style: GoogleFonts.almarai(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text("La version de l'application est ancienne et non prise en charge, vous devez mettre à jour votre application",
                textAlign: TextAlign.center,
                style: GoogleFonts.almarai(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}