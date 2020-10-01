import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/MyOrderDetail.dart';
import 'package:peg/homescreen.dart';

class MyOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: MyOrderFull(),
      ),
    ));
  }
}

class MyOrderFull extends StatefulWidget {
  @override
  _MyOrderFullState createState() => _MyOrderFullState();
}

class _MyOrderFullState extends State<MyOrderFull> {
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
                                "My Order",
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.only(right: 30, left: 30, bottom: 10),
                          child: Stack(
                            children: [
                              Image(
                                  image:
                                      AssetImage("assets/images/ellipse_4.png"),
                                  fit: BoxFit.fill),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 6, top: 6),
                                              child: Text(
                                                "26",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Medium',
                                                    letterSpacing: 0.03,
                                                    fontSize: 16.0,
                                                    color: Color(0xFFff5000)),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 6, top: 6),
                                              child: Text(
                                                "Jan 26, 2020",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Medium',
                                                    letterSpacing: 0.03,
                                                    fontSize: 12.0,
                                                    color: Color(0xFFff5000)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 20),
                                                child: Text(
                                                  "Tracking ID :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Roboto-Medium',
                                                      letterSpacing: 0.03,
                                                      fontSize: 15.0,
                                                      color: Color(0xFFff5000)),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  "Total :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Roboto-Medium',
                                                      letterSpacing: 0.03,
                                                      fontSize: 15.0,
                                                      color: Color(0xFFff5000)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 10, top: 25),
                                                child: Text(
                                                  "23456767 897645",
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
                                                  "205.95",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Roboto-Medium',
                                                      letterSpacing: 0.03,
                                                      fontSize: 15.0,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: InkWell(
                                          onTap: () => Navigator.of(context)
                                              .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          MyOrderDetailFull())),
                                          child: Container(
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/view_order_details.png"),
                                              width: 150,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
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
