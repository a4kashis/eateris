import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eateris/globals.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//myimports
import 'package:eateris/components/cart_products.dart';
import 'package:eateris/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';

import 'Feedback.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightGreen,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  globals.cart_products = [];
                });
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text("Select \nTable :",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    new IconButton(
                      onPressed: minus,
                      icon: new Icon(
                        Icons.arrow_back_ios,
                        color: Colors.pinkAccent,
                        size: 30,
                      ),
                    ),
                    new Text('$tableNum', style: new TextStyle(fontSize: 40.0)),
                    new IconButton(
                      onPressed: add,
                      icon: new Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.pinkAccent,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Expanded(child: new Cart_products()),
        ],
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text('Total'),
              subtitle: new Text('\₹500'),
            )),
            Expanded(
              child: new MaterialButton(
                  onPressed: () {
                    validateAndUpload();
                  },
                  color: Colors.pinkAccent,
                  child: new Text("Place Order",
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }

  void validateAndUpload() async {
    int length = globals.cart_products.length;
    var db = Firestore.instance.collection("orders");
    var batch = Firestore.instance.batch();

    if (length != null) {
      for (int i = 0; i < length; i++) {
        var data = Map<String, dynamic>();
        data = globals.cart_products[i];
        print("index is $i /n$data");
        batch.setData(db.document(), data);
      }
      batch.commit();
      Navigator.pop(context);
      globals.cart_products = [];
      Fluttertoast.showToast(msg: 'Order Placed Successfully');
    } else {
      Fluttertoast.showToast(msg: 'Cart Empty');
    }
  }

  void add() {
    setState(() {
      if (tableNum < 10) tableNum++;
    });
  }

  void minus() {
    setState(() {
      if (tableNum != 1) tableNum--;
    });
  }
}
