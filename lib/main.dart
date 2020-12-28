import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'pages/homePage.dart';

void main(){  

  Map<int, Widget> op = {1: MyApp()};


  runApp(MaterialApp(
    title: 'TKS Mobile',
    debugShowCheckedModeBanner: false,
    // home: MyApp()
    home : AnimatedSplash(
      imagePath: 'images/splash2.png',
      home: HomePage(),
      customFunction: (){
        return 1;
      },
      duration: 2500,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op
    )
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKS Mobile',
      home: HomePage(),
      // theme: ThemeData(
      //   brightness: Brightness.dark
      // ),
    );
  }
}
