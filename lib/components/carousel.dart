import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget image_carousel = new Container(
    height: 200.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('Images/.jpg'),
        AssetImage('Images/Drumset.jpg'),
        AssetImage('Images/Flute.jpg'),
        AssetImage('Images/Tabla.jpg'),
        AssetImage('Images/Trumpet.jpg'),
        AssetImage('Images/Violin.jpg'),
      ],
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 6.0,
      indicatorBgPadding: 8,
      dotBgColor: Colors.transparent,
    ));
