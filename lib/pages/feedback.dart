import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('Images/logo.png'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: false,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Name",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                  style: BorderStyle.solid))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: false,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          hintText: "Phone",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                  style: BorderStyle.solid))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: false,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Address",
                          hintText: "Address",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                  style: BorderStyle.solid))),
                    ),
                  ),


                  SizedBox(
                    height: 30,
                  ),
                  ButtonTheme(
                    //elevation: 4,
                    //color: Colors.green,
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Cash on Delivery'),
                              content: Text(
                                  'Your Order has been Successfully Placed'),
                            );
                          },);
                      },
                      textColor: Colors.white,
                      color: Colors.deepOrange,
                      height: 50,
                      child: Text("PURCHASE"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
