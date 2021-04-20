
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/details_provider.dart';
import 'package:task/provider/products_provider.dart';
import 'package:task/provider/sign_in_provider.dart';
import 'package:task/provider/sign_up_provider.dart';
import 'package:task/screens/cart_screen.dart';
import 'package:task/screens/details_screen.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/products_screen.dart';
import 'package:task/screens/sign_in_screen.dart';
import 'package:task/screens/sign_up_screen.dart';
import 'package:task/screens/splash_screen.dart';

void main() {
  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProductsProvider()),
      ],
      child:  MyApp(),
    ),
  );
 // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.purple,
        primaryColorDark: Color(0xFF512DA8),
        primaryColor: Color(0xFF673AB7),
        primaryColorLight: Color(0xFFD1C4E9),
        accentColor: Color(0xAA03A9F4),
        shadowColor: Colors.deepPurpleAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
              //this = body 1
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              //this = body 2
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 50, 60, 1),
                fontFamily: 'Raleway'
              ),
              //this = title
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
              headline1: TextStyle(
                  fontSize: 16,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              //this for large font
              headline2: TextStyle(
                fontSize: 25,
                fontFamily: 'Raleway',
                color: Colors.black,

                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => Splash(),
        SignUp.routeName: (context) => SignUp(),
        SignIn.routeName: (context) => SignIn(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ProductsScreen.routeName: (context) => ProductsScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
      },
    );
  }
}
