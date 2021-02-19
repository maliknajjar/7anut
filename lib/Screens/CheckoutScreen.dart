import 'package:flutter/material.dart';

import '../Classes/Adresses.dart';
import '../Classes/Dictionairy.dart';

import 'package:shop_app/Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var chosenAddress;
  String payWith;
  String payWithText;
  String recieveAtTime;

  String addressName;


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 1));

    var theWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          Dictionairy.words["Checkout"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        backgroundColor: Colors.yellow[200],
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 7.5,
                bottom: 75,
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 25
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow[50],
                              Colors.yellow[100], 
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ]
                        ),
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 20,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Dictionairy.words["Deliver to"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                            GestureDetector(
                              onTap: (){
                                showDialog(context: context, builder: (BuildContext context){
                                  return StatefulBuilder(
                                    builder: (context, setState){
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.yellow[100],
                                        child: SingleChildScrollView(
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 300
                                            ),
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.pushNamed(context, "/addaddress").then((value){
                                                            setState(() {
                                                              
                                                            });
                                                          });
                                                        },
                                                        child: Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.all(3),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.black.withOpacity(0.1),
                                                                Colors.black.withOpacity(0.05),
                                                              ],
                                                              begin: Alignment.topLeft,
                                                              end: Alignment.bottomRight,
                                                            ),
                                                          ),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.symmetric(
                                                              vertical: 10,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.8),
                                                              borderRadius: BorderRadius.circular(10),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.yellow
                                                                )
                                                              ]
                                                            ),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(Dictionairy.words["Add Address"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
                                                                Container(child: Icon(Icons.add_location_outlined, color: Colors.black.withOpacity(0.75),), margin: EdgeInsets.only(left: 10),)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Addresses.getCurrentUserAddresses().length != 0
                                                      ? Container(
                                                        margin: EdgeInsets.only(bottom: 10, top: 20),
                                                        child: Text(Dictionairy.words["Addresses"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontSize: 20),),
                                                      ) 
                                                      : Container(
                                                        padding: EdgeInsets.all(30),
                                                        alignment: Alignment.center,
                                                        child: Text(Dictionairy.words["There are no Addesses"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.5)),)
                                                      ),
                                                      for (var i = 0; i < Addresses.getCurrentUserAddresses().length; i++)
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.of(context).pop(i);
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                            bottom: 10
                                                          ),
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                            color: Colors.yellow[50],
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.yellow[50],
                                                                Colors.yellow[100],
                                                              ],
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 5,
                                                                spreadRadius: 1,
                                                                color: Colors.black.withOpacity(0.2),
                                                                offset: Offset(2.5, 2.5),
                                                              )
                                                            ],
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          padding: EdgeInsets.all(15),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(Addresses.getCurrentUserAddresses()[i]["title"], style: GoogleFonts.almarai(fontSize: 20),),
                                                              Icon(Icons.location_on_outlined)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      );
                                    },
                                  );
                                }).then((value){
                                  if(value != null){
                                    setState((){
                                      chosenAddress = Addresses.getCurrentUserAddresses()[value];
                                      addressName = Addresses.getCurrentUserAddresses()[value]["title"];
                                      print(chosenAddress);
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[50],
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
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(addressName == null ? Dictionairy.words["Choose Address"][UserInformation.language] : addressName, style: GoogleFonts.almarai(fontSize: 20),),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 25
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow[50],
                              Colors.yellow[100], 
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
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
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 20,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Dictionairy.words["Pay With"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return StatefulBuilder(
                                      builder: (context, setState){
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.yellow[100],
                                          child: SingleChildScrollView(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 300
                                              ),
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){
                                                            Navigator.of(context).pop("Cash");
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                              bottom: 10
                                                            ),
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: Colors.yellow[50],
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Colors.yellow[50],
                                                                  Colors.yellow[100],
                                                                ],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 5,
                                                                  spreadRadius: 1,
                                                                  color: Colors.black.withOpacity(0.2),
                                                                  offset: Offset(2.5, 2.5),
                                                                )
                                                              ],
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            padding: EdgeInsets.all(15),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(Dictionairy.words["Cash"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                                                                Icon(Icons.payments_outlined)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){
                                                            // Navigator.of(context).pop("Credit Card");
                                                          },
                                                          child: Container(
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: Colors.yellow[50],
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Colors.yellow[50],
                                                                  Colors.yellow[100],
                                                                ],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 5,
                                                                  spreadRadius: 1,
                                                                  color: Colors.black.withOpacity(0.2),
                                                                  offset: Offset(2.5, 2.5),
                                                                )
                                                              ],
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            padding: EdgeInsets.all(15),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(Dictionairy.words["payment card"][UserInformation.language] + " (${Dictionairy.words['soon'][UserInformation.language]})", style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.5)),),
                                                                Icon(Icons.payment_outlined, color: Colors.black.withOpacity(0.5)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        );
                                      }
                                    );
                                  }
                                ).then((value){
                                  setState((){
                                    if(value == null) return;
                                    payWith = value;
                                    payWithText = Dictionairy.words[value][UserInformation.language];
                                    print(payWith);
                                  });
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[50],
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
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(payWithText == null ? Dictionairy.words["Choose Payment"][UserInformation.language] : payWithText, style: GoogleFonts.almarai(fontSize: 20),),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 20
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow[50],
                              Colors.yellow[100], 
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
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
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 20,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Dictionairy.words["Deliver at"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return StatefulBuilder(
                                      builder: (context, setState){
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.yellow[100],
                                          child: SingleChildScrollView(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 300
                                              ),
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  for (var i = 1; i < 8; i++)
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){
                                                            Navigator.of(context).pop(DateTime(now.year, now.month, now.day + i).toString().substring(0, 10));
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                              bottom: 10
                                                            ),
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: Colors.yellow[50],
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Colors.yellow[50],
                                                                  Colors.yellow[100],
                                                                ],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 5,
                                                                  spreadRadius: 1,
                                                                  color: Colors.black.withOpacity(0.2),
                                                                  offset: Offset(2.5, 2.5),
                                                                )
                                                              ],
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            padding: EdgeInsets.all(15),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(DateTime(now.year, now.month, now.day + i).toString().substring(0, 10) + (i == 1 ? " (${Dictionairy.words["Tomorrow"][UserInformation.language]})" : ""), style: GoogleFonts.almarai(fontSize: 20),),
                                                                Icon(Icons.date_range_outlined)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        );
                                      }
                                    );
                                  }
                                ).then((value){
                                  setState((){
                                    recieveAtTime = value;
                                  });
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[50],
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
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(recieveAtTime == null ? Dictionairy.words["Choose Date"][UserInformation.language] : recieveAtTime, style: GoogleFonts.almarai(fontSize: 20),),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  if(chosenAddress == null || payWith == null || recieveAtTime == null){
                    // Functions.alert(context, "fill the fields", "you need to fill all the fields");
                    showDialog(context: context, builder: (BuildContext context){
                      return Dialog(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 40,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20, top: 20),
                                      child: Text(Dictionairy.words["Make sure to fill all the fields"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context, rootNavigator: true).pop();
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
                                        child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      );
                    });
                    return;
                  }
                  var information = {"Address": chosenAddress, "Payment Type": payWith, "Recieve Date": recieveAtTime};
                  Navigator.of(context).pushNamed("/confirmation", arguments: information);
                },
                child: Container(
                  height: 60,
                  width: theWidth,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 7.5,
                        offset: Offset(0, 0),
                      ),
                    ]
                  ),
                  child: Center(
                    child: Text(Dictionairy.words["Next"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
