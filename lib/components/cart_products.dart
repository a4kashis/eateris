import 'package:flutter/material.dart';
import 'package:eateris/globals.dart' as globals;

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  @override
  Widget build(BuildContext context) {
    if (globals.cart_products != null) {
      return new ListView.builder(
          itemCount: globals.cart_products.length,
          itemBuilder: (context, index) {
            return Single_cart_product(
                cart_prod_name: globals.cart_products[index]["name"],
                cart_prod_qty: globals.cart_products[index]["quantity"],
                cart_prod_price: globals.cart_products[index]["price"],
                cart_prod_picture: globals.cart_products[index]["picture"],
                tableNum: globals.cart_products[index]["tableNum"],
                );
          });
    } else {
      return Text("EMpty List");
    }
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_qty;
  final tableNum;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_qty,
    this.tableNum
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Card(
        child: ListTile(
          //======== Leading SECTIOM=========
          leading: new Image.network(
            cart_prod_picture,
            width: 80.0,
            height: 80.0,
          ),
          //=======Title Section here====
          title: new Text(cart_prod_name),
//      ======================Subtitle Section==========
          subtitle: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: new Container(
                      alignment: Alignment.topLeft,
                      child: new Text("\₹${cart_prod_price}",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange)),
                    ),
                  ),

                  //==== Size of the product
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: new Text("Qty"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: new Text('${cart_prod_qty}',
                        style: TextStyle(color: Colors.deepOrange)),
                  ),

                  //=======Product color ======
                ],
              ),
              //===========PRODUCT PRICE=======
            ],
          ),
        ),
      ),
    ]);
  }
}
