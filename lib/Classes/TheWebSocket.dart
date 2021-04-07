import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import './Dictionairy.dart';
import './UserInformation.dart';

class TheWebSocket {
  static String theUrl = 'wss://7anut.app';

  static void connect(context){
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(theUrl));
    print("connection established");
    channel.sink.add('{"sessionID": "${UserInformation.sessionID}", "email": "${UserInformation.email}"}');
    channel.stream.listen((message) {
      print(message);
      // channel.sink.close(status.goingAway);      //refrence to how to close the channel from flutter app
    }, onDone: (){
      print("connection is closed");
      noConnection(context);
      // connect();
    }, onError: (error) {
      print("there was an error");
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
                            print("works");
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