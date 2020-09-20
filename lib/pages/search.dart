import 'package:flutter/material.dart';
import 'package:eateris/pages/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

    if (widget.categorySearch == null) {
      getProducts().then((results) {
        setState(() {
          querySnapshot = results;
        });
      });
    } else {
      searchByCategory(widget.categorySearch).then((results) {
        setState(() {
          querySnapshot = results;
        });
      });
    }
  }

  QuerySnapshot querySnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context)),
                Expanded(
                    child: TextField(
                  onSubmitted: (text) {
                    searchProducts(text).then((results) {
                      print(results);
                      setState(() {
                        querySnapshot = results;
                      });
                    });
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search your Favourite Dishes'),
                  textCapitalization: TextCapitalization.words,
                )),
              ],
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
                child: ProductCard(
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
        child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

//get firestore instance
getProducts() async {
  return await Firestore.instance.collection('products').getDocuments();
}

searchProducts(searchtext) async {
  return await Firestore.instance
      .collection('products')
      .where("name", isEqualTo: searchtext)
      .getDocuments();
}

searchByCategory(text) async {
  return await Firestore.instance
      .collection('products')
      .where("category", isEqualTo: text)
      .getDocuments();
}

class ProductCard extends StatelessWidget {
  final brand;
  final name;
  final price;
  final category;
  final picture;
  final description;

  ProductCard(
      {this.name,
      this.brand,
      this.price,
      this.category,
      this.picture,
      this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(
              elevation: 8.0,
              child: Image.network(picture,
                  height: 100, width: double.infinity, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.1,
                  color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("\₹ ${price}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  letterSpacing: 0.2,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("\₹ ${price + (price * (30 / 100))}",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  letterSpacing: 0.2,
                  color: Colors.black.withOpacity(0.6),
                  fontFamily: 'Quicksand',
                )),
          ),
        ]),
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ProductDetails(
                  product_detail_name: name,
                  product_detail_price: price,
                  product_detail_brand: brand,
                  product_detail_category: category,
                  product_detail_picture: picture,
                ))),
      ),
    );
  }
}
