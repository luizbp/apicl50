import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main(){
  runApp(MaterialApp(
    title: 'TKS Mobile',
    debugShowCheckedModeBanner: false,
    home: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKS Mobile',
      home: HomePage(),
    );
  }
}
