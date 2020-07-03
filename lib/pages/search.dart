import 'package:flutter/material.dart';
import 'package:eateris/pages/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eateris/pages/cart.dart';

class SearchResult extends StatefulWidget {
  final categorySearch;

  SearchResult({this.categorySearch});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    super.initState();
    getProducts().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  QuerySnapshot querySnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        actions: <Widget>[
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
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: TextField(
                onSubmitted: (text) {
                  searchProducts(text).then((results) {
                    setState(() {
                      querySnapshot = results;
                    });
                  });
                },
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search your Favourite Dishes',
                    labelText: "Search your Favourite Dishes"),
                textCapitalization: TextCapitalization.words,
              )),
            ),
            _showProducts(),
          ],
        ),
      ),
    );
  }

  Widget _showProducts() {
    List product_list = [];
    //check if querysnapshot is null
    if (querySnapshot != null) {
      product_list = querySnapshot.documents;
      return Flexible(
        child: GridView.builder(
            itemCount: product_list.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Single_prod(
                  name: product_list[i]['name'],
                  brand: product_list[i]['brand'],
                  price: product_list[i]['price'],
                  category: product_list[i]['category'],
                  picture: product_list[i]['picture'],
                  description: product_list[i]['description'],
                ),
              );
            }),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getProducts() async {
    return await Firestore.instance
        .collection('products')
//        .where("name", isEqualTo: searchque)
        .getDocuments();
  }

  searchProducts(searchtext) async {
    return await Firestore.instance
        .collection('products')
        .where("name", isEqualTo: searchtext)
        .getDocuments();
  }
}

class Single_prod extends StatelessWidget {
  final brand;
  final name;
  final price;
  final category;
  final picture;
  final description;

  Single_prod(
      {this.name,
      this.brand,
      this.price,
      this.category,
      this.picture,
      this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 190,
          child: Card(
              child: Material(
            elevation: 8,
            child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new ProductDetails(
                          //Passing the values of the product to the product details page
                          product_detail_name: name,
                          product_detail_price: price,
                          product_detail_brand: brand,
                          product_detail_category: category,
                          product_detail_picture: picture,
                        ))),
                child: GridTile(
                  footer: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
//                            bottomRight: const Radius.circular(5.0),
//                            bottomLeft: const Radius.circular(5.0),
                          )),
//                      color: Colors.green,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: new Text(
                                name,
                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: new Text("\₹ ${price}",
                                style: TextStyle(
                                  letterSpacing: 0.2,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      )),
                  child: Image.network((picture), fit: BoxFit.cover),
                  //Image.asset("Images/products/p1.jpeg",fit: BoxFit.cover,)
                )),
          )),
        ),
      ],
    );
  }
}
