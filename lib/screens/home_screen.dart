import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/cart_screen.dart';
import 'package:task/screens/products_screen.dart';
import 'package:task/widget/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        //backgroundColor: Theme.of(context).primaryColorLight,

        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
                size: 30,
                //  color: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            buildContainerBody(context, "Products", () {
              Navigator.of(context).pushNamed(ProductsScreen.routeName);
            }),
            buildContainerBody(context, "Shopping Cart", () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            }),
          ]),
        ));
  }

  Widget buildContainerBody(
      BuildContext context, String textBody, Function function) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor.withOpacity(.5),
                Theme.of(context).primaryColor,
                //color.withOpacity(.2),
              ])),
      child: InkWell(
        onTap: function,
        child: Center(
          child: Text(
            textBody,
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway'),
          ),
        ),
      ),
    );
  }
}
