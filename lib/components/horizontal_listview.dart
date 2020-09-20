import 'package:eateris/pages/search.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'Images/salad.png',
            image_caption: 'Salad',
          ),
          Category(
            image_location: 'Images/beverages.png',
            image_caption: 'Drinks',
          ),
          Category(
            image_location: 'Images/sandwich.png',
            image_caption: 'Subs',
          ),
          Category(
            image_location: 'Images/fish.png',
            image_caption: 'Fish',
          ),
          Category(
            image_location: 'Images/meat.png',
            image_caption: 'Meat',
          ),
          Category(
            image_location: 'Images/desert.png',
            image_caption: 'Desert',
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
          onTap: () =>
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) =>
                  SearchResult(categorySearch:image_caption))),
          child: Row(
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  new Container(
                      width: 85,
                      child: Image.asset(
                        image_location,
                        width: 60.0,
                        height: 60.0,
                      )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        image_caption,
                        style:
                        new TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                    ),
                  )
                ]),
              )
            ],
          )),
    );
  }
}
