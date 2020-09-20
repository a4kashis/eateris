import 'package:eateris/pages/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eateris/components/horizontal_listview.dart';
import 'package:eateris/pages/cart.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import '../pages/login.dart';
import 'package:eateris/pages/search.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          ExactAssetImage("Images/carousel/offer.jpg"),
          ExactAssetImage("Images/carousel/drinks.jpg"),
          ExactAssetImage("Images/carousel/sandwich.jpg"),
          ExactAssetImage("Images/carousel/pizza.jpg"),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 6.0,
        indicatorBgPadding: 4,
        dotBgColor: Colors.transparent,
      ),
    );
    var items = [];
    return Scaffold(
//      backgroundColor: Colors.blueGrey,
        appBar: new AppBar(
          title: Text('EATERIS'),
          elevation: 0.4,
          backgroundColor: Colors.lightGreen,
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SearchResult()));
                }),
            new IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart()));
                }),
          ],
        ),
        drawer: new Drawer(
          elevation: 0,
          child: new ListView(
            children: <Widget>[
              Container(
                // transform: Matrix4.translationValues(0.0, -40, 0.0),
                child: Image.asset(
                  'Images/logo.png',
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                    title: Text('HOME'),
                    leading: Icon(Icons.home, color: Colors.green)),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart()));
                },
                child: ListTile(
                  title: Text('Food Basket'),
                  leading: Icon(Icons.shopping_cart, color: Colors.redAccent),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Track Food'),
                    leading:
                        Icon(Icons.timelapse_outlined, color: Colors.cyan)),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Get Bill'),
                    leading: Icon(Icons.monetization_on_outlined,
                        color: Colors.red)),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedBack())),
                child: ListTile(
                    title: Text('Feedback'),
                    leading: Icon(Icons.feedback_outlined, color: Colors.blue)),
              ),
              Divider(thickness: 0),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => new Login()));
                  });
                },
                child: ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.transit_enterexit, color: Colors.blue)),
              ),
            ],
          ),
        ),

//        Body
        body: Container(
            child: new CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              new Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    'Today\'s Offers',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
                child: image_carousel,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SearchResult()));
                },
                child: Row(children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'View All products',
                        style: TextStyle(color: Colors.teal),
                      )),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.teal,
                  )
                ]),
              ),
              new Container(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Categories',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              Container(child: HorizontalList()),
              new Container(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Popular Food',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              Container(
//                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 200.0,
                child: ListView(
//                  itemExtent: 50,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Image.asset("Images/carousel/offer.jpg"),
                    Image.asset("Images/carousel/offer.jpg"),
                    Image.asset("Images/carousel/sandwich.jpg")
                  ],
                ),
              ),

//              Products()
            ]),
          ),
        ])));
  }
}
