
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:task/screens/sign_in_screen.dart';


import 'home_screen.dart';
class Splash extends StatefulWidget {
  static String routeName="splash";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new HomeScreen(),
        title: new Text('Please Wait',
          style:Theme.of(context).textTheme.headline6.copyWith(
            color: Theme.of(context).primaryColorDark
          )),
        //image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Theme.of(context).accentColor
    );
  }
}

