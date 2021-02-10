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
    var columnMultiplier = 1;
    theWidth /= columnMultiplier;

    return Container(
      padding: EdgeInsets.only(
          // bottom: 100.5,
          ),
      color: Colors.white70,
      width: double.infinity,
      child: GridView.count(
        padding: EdgeInsets.only(
          top: theWidth * 0.05,
          bottom: 100,
          right: theWidth * 0.025,
          left: theWidth * 0.025,
        ),
        mainAxisSpacing: 15,
        crossAxisSpacing: theWidth * 0.05,
        crossAxisCount: 3 * columnMultiplier,
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
                            Radius.circular(theWidth * 0.06),
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
                      right: theWidth * 0.0225,
                      top: theWidth * 0.0225,
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
                          height: theWidth * 0.085,
                          width: theWidth * 0.085,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(theWidth * 0.035),
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
                            size: theWidth * 0.07,
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
                            fontSize: theWidth * 0.04,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item["size"],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: theWidth * 0.035,
                                  color: Colors.grey),
                            ),
                            Text(
                              item["price"].toString() + "DT",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: theWidth * 0.035,
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
    );
  }
}
