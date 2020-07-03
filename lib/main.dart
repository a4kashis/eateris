import 'package:flutter/material.dart';

//import 'package:eateris/pages/login.dart';
import 'package:eateris/pages/home.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
        ThemeData(primaryColor: Colors.white,fontFamily: 'Raleway'),
        home: Homepage()),
  );
}
