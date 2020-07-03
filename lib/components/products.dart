import 'package:flutter/material.dart';
import 'package:eateris/pages/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
    return _showProducts();
  }

  Widget _showProducts() {
    List product_list = [];
    //check if querysnapshot is null
    if (querySnapshot == null) {
//      return Center(child: Text("Loading..."));
      child:
      return Center(child: CircularProgressIndicator());
    } else {
      product_list = querySnapshot.documents;
      return SliverFixedExtentList(
          itemExtent: 270,
//          itemCount: product_list.length,
//          itemBuilder: (BuildContext context, int i) {
          delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
            return Single_prod(
                name: product_list[i]['name'],
                brand: product_list[i]['brand'],
                price: product_list[i]['price'],
                category: product_list[i]['category'],
                picture: product_list[i]['picture']);
          }));
    }
  }
}

//get firestore instance
getProducts() async {
  return await Firestore.instance.collection('products').getDocuments();
}

class Single_prod extends StatelessWidget {
  final brand;
  final name;
  final price;
  final category;
  final picture;

  Single_prod({this.name, this.brand, this.price, this.category, this.picture});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: name,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
        child: Card(
            elevation: 4.0,
            child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => Hero(
                          tag: name,
                          child: new ProductDetails(
                            //Passing the values of the product to the product details page
                            product_detail_name: name,
                            product_detail_price: price,
                            product_detail_brand: brand,
                            product_detail_category: category,
                            product_detail_picture: picture,
                          ),
                        ))),
                child: GridTile(
                  footer: Container(
                      height: 40,
//                      decoration: BoxDecoration(),
                      color: Colors.white70,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                name,
                                style: TextStyle(
                                    fontFamily: 'Raleway', fontSize: 18.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text("\₹ ${price}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 18.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      )),
                  child: Image.network((picture), fit: BoxFit.cover),
                  //Image.asset("Images/products/p1.jpeg",fit: BoxFit.cover,)
                ))),
      ),
    );
  }
}
