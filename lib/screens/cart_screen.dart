import 'package:flutter/material.dart';
import 'package:task/widget/main_drawer.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "cart_screen";

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Theme.of(context).primaryColorLight,
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(.5),
                            Theme.of(context).primaryColor,
                            //color.withOpacity(.2),
                          ])),
                  child: InkWell(
                    onTap: () {
                      if (_scaffoldKey.currentState.isDrawerOpen) {
                        _scaffoldKey.currentState.openEndDrawer();
                      } else {
                        _scaffoldKey.currentState.openDrawer();
                      }
                    },
                    child: Text(
                      "Menu",
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Raleway'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Theme.of(context).primaryColorDark,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Shopping Cart",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                  color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }
}
