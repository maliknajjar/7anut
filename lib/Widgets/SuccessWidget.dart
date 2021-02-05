import 'package:flutter/material.dart';
import '../Classes/Basket.dart';

class SuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.green.withOpacity(0.2),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 2, color: Colors.black.withOpacity(0.5))),
              ),
              child: Column(
                children: [
                  Icon(Icons.done_outline, size: 100, color: Colors.black.withOpacity(0.5),),
                  Text("Successfully Ordered", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
                ],
              ),
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
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  border: Border.all(
                    width: 1,
                    color: Colors.black.withOpacity(0.5)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Go to Orders Screen", style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.75)),),
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
                    Text("Go to Home Screen", style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.75)),),
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