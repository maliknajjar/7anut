import 'package:flutter/material.dart';
import '../Classes/Adresses.dart';

class AdressesScreen extends StatefulWidget {
  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {
  List<dynamic> currentUsersAddresses = Addresses.getCurrentUserAddresses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Adresses",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
        backgroundColor: Color(0xFF5DA7E6),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_location_alt_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/addaddress").then((value){
                setState(() {
                  currentUsersAddresses = Addresses.getCurrentUserAddresses();
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
                Text("No Addresses Available", style: TextStyle(fontSize: 20),),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.5),
                    border: Border.all(width: 1, color: Colors.black.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: IntrinsicWidth(
                    child: Row(
                      children: [
                        Text("Add Address", style: TextStyle(color: Colors.black.withOpacity(0.75)),),
                        Icon(Icons.add_outlined, color: Colors.black.withOpacity(0.75),)
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
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < currentUsersAddresses.length; i++)
              InkWell(
                hoverColor: Colors.white.withOpacity(0),
                focusColor: Colors.white.withOpacity(0),
                highlightColor: Colors.white.withOpacity(0),
                splashColor: Colors.white.withOpacity(0),
                onTap: (){
                  print(currentUsersAddresses[i].values);
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: Text("Address Information"),
                      content: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item in currentUsersAddresses[i].values)
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
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(currentUsersAddresses[i]["title"], style: TextStyle(fontSize: 25),),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
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
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.delete_outline, size: 30, color: Colors.red,),
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
