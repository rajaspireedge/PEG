import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/homescreen.dart';

class Checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(child: CheckoutFull()),
    ));
  }
}

class CheckoutFull extends StatefulWidget {
  @override
  _CheckoutFullState createState() => _CheckoutFullState();
}

var back_1 = new AssetImage('assets/images/back_1.png');
var borderimg = new AssetImage('assets/images/rounded_rectangle_234.png');

class _CheckoutFullState extends State<CheckoutFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          child: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/allbg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Center(
                    child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                              child: Image(
                                image: AssetImage('assets/images/back_12.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Checkout",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto-Bold',
                                    letterSpacing: 0.03,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.0),
                      color: Color(0xFF0a0f32),
                      height: 80,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: borderimg,
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Order Summary ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto-Medium',
                                          letterSpacing: 0.03,
                                          fontSize: 16.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 20.0),
                                  child: Image(
                                    image: back_1,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 30 , left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Logged in",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Medium',
                                  letterSpacing: 0.03,
                                  fontSize: 16.0,
                                  color: Color(0xFFff5000)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20.0),
                            child: Image(
                              image: AssetImage('assets/images/correct_2.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              )
            ],
          ),
          onWillPop: () async {
            return Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Homescreen()));
          }),
    );
  }
}
