import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Classes/Basket.dart';
import '../Classes/Procucts.dart';

class CategoryWidget extends StatefulWidget {
  String category;
  Function() refresh;
  CategoryWidget(String cat, this.refresh) {
    category = cat;
  }

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState(category);
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String category;

  _CategoryWidgetState(String cat) {
    category = cat;
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: GridView.count(
          padding: EdgeInsets.only(
            top: theWidth < 600 ? theWidth * 0.05 : 30,
            bottom: 100,
            right: theWidth < 600 ? theWidth * 0.05 : 30,
            left: theWidth < 600 ? theWidth * 0.05 : 30,
          ),
          mainAxisSpacing: 15,
          crossAxisSpacing: theWidth < 600 ? theWidth * 0.05 : 30,
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          children: <Widget>[
            for (var item in Products.getProductsByCategory(category))
              Column(
                children: <Widget>[
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: 100,
                          height: 100,
                          child: FittedBox(
                            child: Text(
                              Basket.getQtyById(
                                item["ID"].toString(),
                              ),
                              style: TextStyle(
                                fontSize: 110,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item["imageUrl"]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(theWidth < 600 ? theWidth * 0.05 : 35),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: theWidth < 600 ? theWidth * 0.0225 : 15,
                        top: theWidth < 600 ? theWidth * 0.0225 : 15,
                        child: InkWell(
                          onTap: () {
                            Basket.addItem(
                                item["ID"].toString(),
                                item["Name"],
                                item["size"],
                                item["imageUrl"],
                                item["price"].toString());
                            widget.refresh();
                          },
                          child: Container(
                            height: theWidth < 600 ? theWidth * 0.085 : 50,
                            width: theWidth < 600 ? theWidth * 0.085 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(theWidth < 600 ? theWidth * 0.035 : 20),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add,
                              size: theWidth < 600 ? theWidth * 0.07 : 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 7.5,
                        left: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["Name"],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: theWidth < 600 ? theWidth * 0.04 : 35,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item["size"],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: theWidth < 600 ? theWidth * 0.035 : 35,
                                    color: Colors.grey),
                              ),
                              Text(
                                item["price"].toString() + "DT",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: theWidth < 600 ? theWidth * 0.035 : 35,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
