import 'package:flutter/material.dart';
import '../Classes/Adresses.dart';

class AdressesScreen extends StatefulWidget {
  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {
  // List<dynamic> currentUsersAddresses = Addresses.getCurrentUserAddresses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          "Adresses",
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        backgroundColor: Colors.yellow[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_location_alt_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/addaddress").then((value){
                setState(() {
                  
                });
              });
            },
          )
        ],
      ),
      body: !Addresses.isEmpty()
        ? InkWell(
          onTap: (){
            Navigator.of(context).pushNamed("/addaddress").then((value){
              setState(() {
                              
              });
            });
          },
          child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("No Addresses", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -5,
                      color: Colors.black.withOpacity(0.35),
                      offset: Offset(5, 5),
                    )
                  ]
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Addresses", style: TextStyle(color: Colors.black.withOpacity(0.75), fontSize: 20),),
                      Icon(Icons.arrow_forward, color: Colors.black.withOpacity(0.75),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        )
        : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 15,
            left: 15,
            right: 15,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < Addresses.getCurrentUserAddresses().length; i++)
              InkWell(
                hoverColor: Colors.white.withOpacity(0),
                focusColor: Colors.white.withOpacity(0),
                highlightColor: Colors.white.withOpacity(0),
                splashColor: Colors.white.withOpacity(0),
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context){
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.yellow[50],
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 40,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20, top: 20),
                                    child: Text("Address Information", style: TextStyle(fontSize: 20),),
                                  ),
                                  for (var item in Addresses.getCurrentUserAddresses()[i].values)
                                  if (item != null)
                                  Text(item.toString()),
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
                                      child: Text("Ok", style: TextStyle(fontSize: 16),),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  }).then((value){
                    print(i);
                    if (value == null) return;
                    if (value){
                      setState(() {
                        Addresses.deleteAddress(i);
                        print("done");
                      });
                    }
                  });

                  // showDialog(
                  //   context: context,
                  //   builder: (context) => new AlertDialog(
                  //     title: Text("Address Information"),
                  //     content: IntrinsicHeight(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           for (var item in Addresses.getCurrentUserAddresses()[i].values)
                  //           if (item != null)
                  //           Text(item.toString()),
                  //         ],
                  //       ),
                  //     ),
                  //     actions: <Widget>[
                  //       new TextButton(
                  //         onPressed: () {
                  //           Navigator.of(context, rootNavigator: true).pop();
                  //         },
                  //         child: Text("OK")
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    left: 15,
                    right: 15,
                  ),
                  margin: EdgeInsets.only(bottom: 15),
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
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(Addresses.getCurrentUserAddresses()[i]["title"], style: TextStyle(fontSize: 25),),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.yellow[50],
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 40, top: 20),
                                      child: Text("Are you sure you want to delete this address ?", style: TextStyle(fontSize: 16),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context, rootNavigator: true).pop(false);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
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
                                              child: Text("Cancel", style: TextStyle(fontSize: 16),),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context, rootNavigator: true).pop(true);
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
                                              child: Text("Ok", style: TextStyle(fontSize: 16),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            );
                          }).then((value){
                            print(i);
                            if (value == null) return;
                            if (value){
                              setState(() {
                                Addresses.deleteAddress(i);
                                print("done");
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            gradient: LinearGradient(
                              colors: [Colors.red.withOpacity(0.25), Colors.red[50].withOpacity(0.25)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red[50],
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(2.5, 2.5),
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.delete_outline, size: 30, color: Colors.red,),
                          ),
                        ),
                      ),
                    ],
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
