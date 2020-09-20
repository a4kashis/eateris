import 'package:eateris/globals.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './feedback.dart';
import './cart.dart';
import 'package:eateris/globals.dart' as globals;

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
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
                transform: Matrix4.translationValues(0.0, -0.0, 0.0),
                child: Image.network(widget.product_detail_picture,
                    height: 280, fit: BoxFit.cover)),
            Positioned(
              top: 40,
              left: 8.0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.white70,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: new Text(widget.product_detail_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                      ),
                      Text("\₹${widget.product_detail_price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ])),
              ),
            ),
          ]),

          //==========Buttons ROW ============
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new FeedBack()));
                  },
                  color: Colors.green,
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
                    print('qty$_n');
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
              custom
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: 4,
                          controller: descController,
                          decoration: InputDecoration.collapsed(
                              hintText: "Any Changes to dish?"),
                        ),
                      ),
                    )
                  : Container(),
            ]),
          ),
          Divider(),

          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Category:",
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
