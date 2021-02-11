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
                  print(Addresses.getCurrentUserAddresses()[i].values);
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: Text("Address Information"),
                      content: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item in Addresses.getCurrentUserAddresses()[i].values)
                            if (item != null)
                            Text(item.toString()),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("OK")
                        ),
                      ],
                    ),
                  );
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
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 100
                                ),
                                child: Text("are you sure you want to delete the Address?"),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop(false);
                                  },
                                  child: Text("Cancel")
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop(true);
                                  },
                                  child: Text("OK")
                                ),
                              ],
                            ),
                          ).then((value){
                            if (value == null) return;
                            if (!value){
                              return;
                            }else{
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
                              colors: [Colors.red.withOpacity(0.5), Colors.red[50].withOpacity(0.5)],
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
