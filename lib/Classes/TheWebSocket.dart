import 'package:flutter/material.dart';
import 'package:shop_app/Classes/Basket.dart';
import 'package:shop_app/Classes/Functions.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import './Dictionairy.dart';
import './UserInformation.dart';

class TheWebSocket {
  static String theUrl = 'wss://7anut.app';
  static bool isDone = false;
  static bool withoutDialogue = false;
  static WebSocketChannel channel;

  static void connect(context){
    channel = WebSocketChannel.connect(Uri.parse(theUrl));
    channel.sink.add('{"sessionID": "${UserInformation.sessionID}", "email": "${UserInformation.email}"}');
    channel.stream.listen((message) {
      // channel.sink.close(status.goingAway);      //refrence to how to close the channel from flutter app
      if(message == "session is wrong"){
        Functions.logout(context, "session error", Colors.red);
        isDone = true;
        return;
      }
    }, onDone: (){
      if(isDone == false){
        Basket.clearBasket();
        Basket.simpleArray.clear();
        if(withoutDialogue == true) return channel.sink.close();
        noConnection(context);
      }
      isDone = false;
    }, onError: (error) {

    });
  }

  static closeConnectionManually(){
    withoutDialogue = true;
    channel.sink.close().then((value){
      Future.delayed(const Duration(milliseconds: 500), (){
        withoutDialogue = false;
      });
    });
  }
  
  static void noConnection(context){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      return StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: Colors.yellow[50],
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      child: Text(Dictionairy.words["connection error message"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Phoenix.rebirth(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.025),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(Dictionairy.words["Reconnect"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
          );
        }
      );
    }).then((value){
      
    });
  }
}