import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/MyOrder.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/main.dart';
import 'package:http/http.dart' as http;

import 'PaymentScreen.dart';

class MyOrderDetail extends StatelessWidget {
  String userid;
  String orderid;

  MyOrderDetail(this.userid, this.orderid);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: MyOrderDetailFull(userid, orderid),
      ),
    ));
  }
}

class MyOrderDetailFull extends StatefulWidget {
  String userid;
  String orderid;

  MyOrderDetailFull(this.userid, this.orderid);

  @override
  _MyOrderDetailFullState createState() =>
      _MyOrderDetailFullState(userid, orderid);
}

class _MyOrderDetailFullState extends State<MyOrderDetailFull> {
  String userid;
  String orderid;

  _MyOrderDetailFullState(this.userid, this.orderid);

  List<Map<String, dynamic>> snapshotitemlist;
  List<dynamic> atrlbl = List();
  List<dynamic> optlbl = List();

  Future<String> getSWData(String id, String orderid) async {
    var res = await http.get(
        Uri.encodeFull(
            RestDatasource.get_my_order_details + id + "/" + orderid),
        headers: {"Accept": "application/json"});

    getStringValuesSF().then((value) => {userid = value});

    setState(() {
      snapshotitemlist = List<Map<String, dynamic>>.from(
          json.decode(res.body)['order_details']);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData(this.userid, this.orderid);
  }

  @override
  Widget build(BuildContext context) {
    if (snapshotitemlist == null) {
      return Container(
        color: Color(0xFF0a0f32),
        child: Center(
          child: Loading(
              indicator: BallPulseIndicator(), size: 100.0, color: color3),
        ),
      );
    }
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
              Column(
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
                              "My Order Detail",
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
                  Expanded(
                      child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              atrlbl = snapshotitemlist[index]
                                  ["product_attributes"]["atrlbl"];
                              optlbl = snapshotitemlist[index]
                                  ["product_attributes"]["optlbl"];

                              String payment = "Paypal";

                              if (snapshotitemlist[index]["payment_method"] ==
                                  "0") {
                                payment = "Wallet";
                              }

                              print(atrlbl);
                              print(optlbl);

                              String trackingid = "";
                              if (snapshotitemlist[index]["tracking_id"] ==
                                  null) {
                                trackingid = "N/A";
                              } else {
                                trackingid =
                                    snapshotitemlist[index]["tracking_id"];
                              }

                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 30, left: 30, bottom: 10),
                                    child: Stack(
                                      children: [
                                        Image(
                                            image: AssetImage(
                                                "assets/images/rectangle_12.png"),
                                            height: 470,
                                            width: double.infinity,
                                            fit: BoxFit.fill),
                                        Image(
                                            image: AssetImage(
                                                "assets/images/ellipse_42.png"),
                                            width: 200,
                                            fit: BoxFit.fill),
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10, top: 10),
                                                        child: Text(
                                                          snapshotitemlist[
                                                              index]["id"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Roboto-Medium',
                                                              letterSpacing:
                                                                  0.03,
                                                              fontSize: 16.0,
                                                              color: Color(
                                                                  0xFFff5000)),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 55, top: 20),
                                                        child: Text(
                                                          snapshotitemlist[
                                                                  index]
                                                              ["product_name"],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto-Bold',
                                                              letterSpacing:
                                                                  0.03,
                                                              fontSize: 10.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 6, top: 6),
                                                        child: Text(
                                                          snapshotitemlist[
                                                                  index]
                                                              ["created_at"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Roboto-Medium',
                                                              letterSpacing:
                                                                  0.03,
                                                              fontSize: 12.0,
                                                              color: Color(
                                                                  0xFFff5000)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 40,
                                                                  bottom: 30),
                                                          child: Image(
                                                              image: NetworkImage(
                                                                  snapshotitemlist[
                                                                          index]
                                                                      [
                                                                      "product_image"]),
                                                              height: 80,
                                                              width: 80,
                                                              fit: BoxFit
                                                                  .scaleDown),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 20),
                                                          child: Text(
                                                            "Quantity :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Tracking ID :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Payment Method :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Shipping Fee :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Wallet Deducted :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Paypal Deducted :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Amount :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Processing :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  top: 10),
                                                          child: Text(
                                                            "Gross Total :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Color(
                                                                    0xFFff5000)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          height: 90,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 40,
                                                                  bottom: 30),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListView
                                                                    .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      child:
                                                                          Text(
                                                                        atrlbl[index] +
                                                                            ": " +
                                                                            optlbl[index],
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontFamily:
                                                                                'Roboto-Medium',
                                                                            letterSpacing:
                                                                                0.03,
                                                                            fontSize:
                                                                                15.0,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    );
                                                                  },
                                                                  itemCount:
                                                                      atrlbl
                                                                          .length,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            snapshotitemlist[
                                                                index]["qty"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            trackingid,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            payment,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(
                                                                    new Runes(
                                                                        '\u0024')) +
                                                                snapshotitemlist[
                                                                        index][
                                                                    "shipping_charge"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(
                                                                    new Runes(
                                                                        '\u0024')) +
                                                                snapshotitemlist[
                                                                        index][
                                                                    "wallet_deducted"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                                  new String.fromCharCodes(
                                                                  new Runes(
                                                                  '\u0024')) +
                                                                  snapshotitemlist[
                                                                  index][
                                                                  "paypal_deducted"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(
                                                                new Runes(
                                                                    '\u0024')) +
                                                                snapshotitemlist[
                                                                index][
                                                                "amount"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(
                                                                new Runes(
                                                                    '\u0024')) +
                                                                snapshotitemlist[
                                                                index][
                                                                "product_fee"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(
                                                                new Runes(
                                                                    '\u0024')) +
                                                                snapshotitemlist[
                                                                index][
                                                                "sub_total"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Roboto-Medium',
                                                                letterSpacing:
                                                                    0.03,
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                            itemCount: snapshotitemlist.length,
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ],
          ),
          onWillPop: () async {
            return getStringValuesSF().then((value) => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MyOrder(value))));
          }),
    );
  }
}
