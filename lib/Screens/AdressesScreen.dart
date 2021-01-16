import 'package:flutter/material.dart';
import '../Classes/Adresses.dart';

class AdressesScreen extends StatefulWidget {
  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {

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
                                  
                });
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < Addresses.addressesBasket.length; i++)
              GestureDetector(
                onTap: (){
                  // Navigator.of(context).pushNamed("/addaddress");
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(Addresses.addressesBasket[i]["title"], style: TextStyle(fontSize: 25),),
                          ),
                          Container(
                            child: Text(Addresses.addressesBasket[i]["location"]["latitude"].toString().substring(0, 6) + ", " + Addresses.addressesBasket[i]["location"]["longitude"].toString().substring(0, 6), style: TextStyle(fontSize: 15),),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            Addresses.deleteAddress(i);                        
                          });
                        },
                        child: Container(
                          child: Icon(Icons.delete, size: 30, color: Colors.red,),
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
