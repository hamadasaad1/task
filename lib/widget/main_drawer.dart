import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screens/cart_screen.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/products_screen.dart';
import 'package:task/screens/sign_in_screen.dart';
import 'package:task/screens/sign_up_screen.dart';
import 'package:task/services/constans.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(String title, IconData icon, Function fun) {
    return ListTile(
      //leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          // fontWeight: FontWeight.bold
        ),
      ),
      onTap: fun,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            color: Theme
                .of(context)
                .primaryColorLight,
            padding: EdgeInsets.all(10),
            child: Text(
              "Welcome😃",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme
                      .of(context)
                      .primaryColor),
            ),
          ),
          SizedBox(height: 20),
          _buildListTile("Home", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
          _buildListTile("Sign-Up", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(SignUp.routeName);
          }),
          _buildListTile("Sign-In", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(SignIn.routeName);
          }),
          _buildListTile("Products", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(
                ProductsScreen.routeName);
          }),
          _buildListTile("Shopping Cart", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
          }),
          _buildListTile("Sign Out ", Icons.settings, () {
            _deleteDateFromShardPre();
             Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
          _buildListTile("Dark/Light Mode", Icons.settings, () {
            // Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }

  _deleteDateFromShardPre() async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString(SECURITY_TOKEN, "");
    sharedPreferences.setString(USERID, "");
    sharedPreferences.setString(USERNAME, "");
  }
}
