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
              // header
              new UserAccountsDrawerHeader(
                accountName: Text('HELLO'),
                accountEmail: Text('Table1@eateris'),
                currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 40.0,
                        ))),
                decoration: new BoxDecoration(color: Colors.lightGreen),
              ),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                    title: Text('HOME'),
                    leading: Icon(Icons.home, color: Colors.deepOrange)),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart()));
                },
                child: ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(Icons.shopping_cart, color: Colors.deepOrange),
                ),
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
                child: Stack(children: <Widget>[
                  Image.asset(
                    'Images/logo.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: -1,
                    right: 10,
                    child: Container(
                        height: 25,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen,
//                            color: Color(0xFFE7FFAC),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(30.0),
                              topRight: const Radius.circular(30.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 8, 8.0, 0),
                          child: Text("The Smartfood"),
                        )),
                  ),
                ], overflow: Overflow.visible),
              ),
              new Container(
                height: 35,
//                decoration: BoxDecoration(color: Colors.white),
//                decoration: BoxDecoration(color: Colors.lightGreen),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    'Daily Offers',
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
                        'Veiw All products',
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
