import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/PaymentScreen.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/main.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatelessWidget {
  String checkinsideoutside;
  String userid;

  Checkout({Key key, @required this.checkinsideoutside, this.userid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
          child: CheckoutFull(
        checkinsideoutside: checkinsideoutside,
      )),
    ));
  }
}

class CheckoutFull extends StatefulWidget {
  String checkinsideoutside;
  String userid;

  CheckoutFull({Key key, @required this.checkinsideoutside, this.userid})
      : super(key: key);

  @override
  _CheckoutFullState createState() =>
      _CheckoutFullState(checkinsideoutside, userid);
}

var back_1 = new AssetImage('assets/images/back_1.png');
var borderimg2 = new AssetImage('assets/images/rounded_rectangle_234.png');
var borderimg = new AssetImage('assets/images/borderimg.png');

bool checkvalue = false;

String userid = "";

final billingemail = TextEditingController();
final billingname = TextEditingController();
final billingaddress = TextEditingController();
final billingcountry = TextEditingController();
final billingstate = TextEditingController();
final billingcity = TextEditingController();
final billingzipcode = TextEditingController();
final billingziphone = TextEditingController();

final shipingemail = TextEditingController();
final shipingname = TextEditingController();
final shipingaddresszz = TextEditingController();
final shipingcountry = TextEditingController();
final shipingstate = TextEditingController();
final shipingcity = TextEditingController();
final shipingzipcode = TextEditingController();
final shipingphone = TextEditingController();

class _CheckoutFullState extends State<CheckoutFull> {
  String checkinsideoutside;
  String userid;

  _CheckoutFullState(this.checkinsideoutside, this.userid);

  Map<String, dynamic> snapshotplayerlist = Map();

  Future<String> getSWData(String userid) async {
    print(userid);

    var res = await http.get(
        Uri.encodeFull(RestDatasource.get_profile_info + userid),
        headers: {"Accept": "application/json"});

    setState(() {
      snapshotplayerlist =
          Map<String, dynamic>.from(json.decode(res.body)['user_profile']);
      print(snapshotplayerlist);
    });

    return "Success";
  }

  void addpayment(String value) {
    Map<String, String> map = new Map();
    map["user_id"] = value;
    map["name"] = billingname.text;
    map["email"] = billingemail.text;
    map["phone"] = "123";
    map["address"] = billingaddress.text;
    map["country"] = billingcountry.text;
    map["countrysortname"] = "US";
    map["state"] = billingstate.text;
    map["city"] = "city";
    map["zip_code"] = billingzipcode.text;

    if (shipingaddresszz.text == "") {

      map["shippping_address"] = billingaddress.text;
    } else {
      map["shippping_address"] = shipingaddresszz.text;
    }

    if (shipingcountry.text == "") {
      map["shipping_country"] = billingcountry.text;

    } else {
      map["shipping_country"] = shipingcountry.text;
    }

    map["shipping_countrysortname"] = "US";

    if (shipingstate.text == "") {

      map["shipping_state"] = billingstate.text;
    } else {
      map["shipping_state"] = shipingstate.text;
    }

    if (shipingcity.text == "") {

      map["shiptocity"] = billingcity.text;
    } else {
      map["shiptocity"] = shipingcity.text;
    }

    if (shipingzipcode.text == "") {

      map["shiptozip"] = billingzipcode.text;
    } else {
      map["shiptozip"] = shipingzipcode.text;
    }

    map["shipping_location_type"] = checkinsideoutside;
    map["ship_to_diffadd_check"] = "off";

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Payment(map)));
  }

  @override
  void initState() {
    super.initState();

    getStringValuesSF().then((value) => {this.getSWData(value)});
  }

  @override
  Widget build(BuildContext context) {
    billingname.text = snapshotplayerlist["name"];
    billingemail.text = snapshotplayerlist["email"];
    billingaddress.text = snapshotplayerlist["location"];
    billingcountry.text = snapshotplayerlist["country"];
    billingstate.text = snapshotplayerlist["state"];
    billingzipcode.text = snapshotplayerlist["zip_code"];

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
                                image: borderimg2,
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
                      margin: EdgeInsets.only(right: 30, left: 30, top: 20),
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
                                  fontSize: 18.0,
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
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Contact and Billing Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Medium',
                                  letterSpacing: 0.03,
                                  fontSize: 18.0,
                                  color: Color(0xFFff5000)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20.0),
                            child: Image(
                              image: AssetImage('assets/images/reload.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingemail,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Email ID",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingname,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Name",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingaddress,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Address",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingcountry,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Country",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingstate,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "State",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingcity,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "City",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingzipcode,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Zip Code",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: borderimg,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextField(
                            style: style,
                            controller: billingziphone,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Phone",
                              border: InputBorder.none,
                              hintStyle: hintstyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (checkvalue) {
                                  checkvalue = false;
                                } else {
                                  checkvalue = true;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 2.0),
                                    height: 20,
                                    width: 20,
                                    child: Container(
                                      child: Image(
                                          image: checkvalue
                                              ? AssetImage(
                                                  "assets/images/correct_5_copy_2.png")
                                              : AssetImage(
                                                  "assets/images/rounded_rectangle_3.png")),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(right: 30),
                            child: Text(
                              "Ship to different address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Medium',
                                  letterSpacing: 0.03,
                                  fontSize: 16.0,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    shipingaddress(),
                    Container(
                      child: new InkWell(
                        onTap: () {
                          getStringValuesSF()
                              .then((value) => addpayment(value));
                        },
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: new Image(
                                image: AssetImage(
                                    'assets/images/group_2_copy_258.png'),
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
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

Widget shipingaddress() {
  return Column(
    children: [
      Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: borderimg,
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              style: style,
              controller: shipingaddresszz,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Address",
                border: InputBorder.none,
                hintStyle: hintstyle,
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: borderimg,
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              style: style,
              controller: shipingcountry,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Country",
                border: InputBorder.none,
                hintStyle: hintstyle,
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: borderimg,
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              style: style,
              controller: shipingstate,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "State",
                border: InputBorder.none,
                hintStyle: hintstyle,
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: borderimg,
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              style: style,
              controller: shipingcity,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "City",
                border: InputBorder.none,
                hintStyle: hintstyle,
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: borderimg,
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              style: style,
              controller: shipingzipcode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Zip Code",
                border: InputBorder.none,
                hintStyle: hintstyle,
              ),
            ),
          )
        ],
      ),
      Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: borderimg,
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              style: style,
              controller: shipingphone,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Phone",
                border: InputBorder.none,
                hintStyle: hintstyle,
              ),
            ),
          )
        ],
      ),
    ],
  );
}

TextStyle hintstyle =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white);
