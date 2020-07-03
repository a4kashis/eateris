import 'package:eateris/globals.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './Feedback.dart';
import './cart.dart';
import 'package:eateris/globals.dart' as globals;
import 'package:numberpicker/numberpicker.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;
  final product_detail_brand;
  final product_detail_category;
  final product_detail_description;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_price,
      this.product_detail_picture,
      this.product_detail_brand,
      this.product_detail_category,
      this.product_detail_description});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

int _n = 1;
bool spicy = false;
bool custom = false;
TextEditingController descController = TextEditingController();

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightGreen,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Homepage()));
            },
            child: Text("Eateris")),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart()));
              }),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                    color: Colors.white,
                    child: Image.network(widget.product_detail_picture)),
                footer: new Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: new Text(widget.product_detail_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      title: new Row(
                        children: <Widget>[
                          Expanded(
                              child: new Text(
                                  "\₹${widget.product_detail_price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))),
                        ],
                      ),
                    )),
              )),

          //==========Buttons ROW ============
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {

                    print(globals.customDesc = descController.text);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new Buynow()));
                  },
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text("Order Now"),
                ),
              ),
              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    globals.customDesc = descController.text;
                    globals.cart_products.add({
                      "tableNum": globals.tableNum,
                      "name": widget.product_detail_name,
                      "quantity": _n,
                      "spice": spicy,
                      "customDesc": globals.customDesc,
                      "price": widget.product_detail_price,
                      "picture": widget.product_detail_picture,
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new Cart()));
                  }),
            ],
          ),
          Container(
            child: new Row(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 5.0, 50.0, 5.0),
                    child: new Text("Quantity",
                        style: TextStyle(color: Colors.grey))),
                new IconButton(
                  onPressed: minus,
                  icon: new Icon(
                    Icons.remove,
                    color: Colors.pinkAccent,
                    size: 35,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 2),
                  child: new Text('$_n', style: new TextStyle(fontSize: 40.0)),
                ),
                new IconButton(
                  onPressed: add,
                  icon: new Icon(
                    Icons.add,
                    color: Colors.pinkAccent,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),

          Divider(),
          new ListTile(
            title: new Text("Food Details"),
            subtitle: Column(children: <Widget>[
              new SizedBox(
                height: 5,
              ),
              new Text(
//                widget.product_detail_description +
                    "Delicious mixed vegetable patties in burger buns with sauce & simple mayo hung curd \nWith love - Eateris",
                style: TextStyle(height: 1.5),
              ),
              Row(children: <Widget>[
                Text("Spicy?"),
                Checkbox(
                  value: spicy,
                  checkColor: Colors.white,
                  activeColor: Colors.redAccent,
                  onChanged: (bool value) {
                    setState(() {
                      spicy = value;
                    });
                  },
                ),
                Text("Custom Description"),

                Checkbox(
                  value: custom,
                  checkColor: Colors.white,
                  activeColor: Colors.lightGreen,
                  onChanged: (bool value) {
                    setState(() {
                      custom = value;
                    });
                  },
                )
              ]),
              new Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 4,
                    controller: descController,
//                    onSubmitted: (String str) {
//                      setState(() {
//                        globals.customDesc = str;
//                      });
//                    },
                    decoration: InputDecoration.collapsed(
                        hintText: "Any Changes to dish?"),
                  ),
                ),
              ),
            ]),
          ),
          Divider(),

          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Food Name:",
                      style: TextStyle(color: Colors.grey))),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(widget.product_detail_name))
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Food Category:",
                      style: TextStyle(color: Colors.grey))),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(widget.product_detail_category))
            ],
          ),
        ],
      ),
    );
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 1) _n--;
    });
  }
}
