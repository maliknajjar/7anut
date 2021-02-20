import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingLogo extends StatefulWidget {
  @override
  _LoadingLogoState createState() => _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
      _controller = AnimationController(
        vsync: this, // the SingleTickerProviderStateMixin
        duration: Duration(milliseconds: 2000),
        
      );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/images/logo-01.png",
                height: 35,
              ),
            ),
            AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child){
                return Transform.translate(
                  offset: Offset(lerpDouble(-200, 200, _controller.value), 0),
                  child: child,
                );
              },
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  width: 25,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.75),
                        blurRadius: 10,
                        // spreadRadius: 0.5
                      )
                    ]
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}