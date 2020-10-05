import 'package:flutter/material.dart';
import 'package:peg/homescreen.dart';

class Addtocart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: AddtoCARTfull(),
      ),
    ));
  }
}

class AddtoCARTfull extends StatefulWidget {
  @override
  _AddtoCARTfullState createState() => _AddtoCARTfullState();
}

class _AddtoCARTfullState extends State<AddtoCARTfull> {
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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Homescreen()));
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/back_12.png'),
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Cart",
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
                    Container(
                      margin: EdgeInsets.only(right: 30, left: 30, bottom: 10),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/rounded_rectangle_4.png"),
                                          fit: BoxFit.fill),
                                      Align(
                                        alignment: Alignment.topRight,

                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 30, left: 30, top: 20),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/icons_8_delete_bin_24.png"),
                                              height: 30,
                                              width: 20,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: 200,
                                              height: 30,
                                              child: Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30),
                                                    child: Text(
                                                      "FUEL FEST VIP BADGES",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(
                                                  right: 30, top: 20),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30, top: 20),
                                                    child: Image(
                                                        image: AssetImage(
                                                            "assets/images/demoo.png"),
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.fill),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30, top: 20),
                                                    child: Text(
                                                      "Quantity :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Color(
                                                              0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30, top: 10),
                                                    child: Text(
                                                      "Amount :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Color(
                                                              0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30, top: 10),
                                                    child: Text(
                                                      "Processing :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Color(
                                                              0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 30, top: 10),
                                                    child: Text(
                                                      "Gross Total :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Color(
                                                              0xFFff5000)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 90,
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 20),
                                                    child: Text(
                                                      "Badge Stlye : Custom VIP Badge 5 Custom Tag  Pro Esports Gaming",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    child: Text(
                                                      "1",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    child: Text(
                                                      "204.00",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    child: Text(
                                                      "1.00",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    child: Text(
                                                      "205.00",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )),
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
