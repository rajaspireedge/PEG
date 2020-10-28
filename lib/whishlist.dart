import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/PaymentScreen.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:peg/main.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: WishListFull(),
      ),
    ));
  }
}

class WishListFull extends StatefulWidget {
  @override
  _WishListFullState createState() => _WishListFullState();
}

class _WishListFullState extends State<WishListFull> {
  List<Map<String, dynamic>> snapshotitemlist;
  List<dynamic> atrlbl = List();
  List<dynamic> optlbl = List();

  Future<String> getSWData(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.wishlist + id), headers: {"Accept": "application/json"});

    if (json.decode(res.body)["status_code"] == 400) {
      if (json.decode(res.body)["message"] == "Your Wishlist is Empty") {
        setState(() {
          snapshotitemlist = List();
          snapshotitemlist.clear();
        });
      }

      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);

      throw new Exception(json.decode(res.body));
    } else {
      setState(() {
        snapshotitemlist = List<Map<String, dynamic>>.from(json.decode(res.body)['wish_list']);
        print(snapshotitemlist);
      });
    }

    return "Success";
  }

  Future<String> addcarttowishlist(String id, BuildContext context) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.add_to_cart_from_wishlist_product + id), headers: {"Accept": "application/json"});

    Navigator.pop(context);
    if (json.decode(res.body)["status_code"] == 400) {
      Fluttertoast.showToast(msg: json.decode(res.body)["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      getStringValuesSF().then((value) => getSWData(value));
      throw new Exception(json.decode(res.body));
    } else {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      getStringValuesSF().then((value) => getSWData(value));
    }

    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF().then((value) => this.getSWData(value));
  }

  @override
  Widget build(BuildContext context) {
    if (snapshotitemlist == null) {
      return Container(
        color: Color(0xFF0a0f32),
        child: Center(
          child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: color3),
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
                              "Wishlist",
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Homescreen(),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image(
                        image: AssetImage("assets/images/go_to_store22.png"),
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 30, left: 30, bottom: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                atrlbl = snapshotitemlist[index]["sel_variation"]["atrlbl"];
                                optlbl = snapshotitemlist[index]["sel_variation"]["optlbl"];

                                double total = double.parse(snapshotitemlist[index]["amount"].toString());
                                double fee = double.parse(snapshotitemlist[index]["product_fee"].toString());
                                double grandtotal = total + fee;

                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Stack(
                                    children: [
                                      Image(image: AssetImage("assets/images/rounded_rectangle_4.png"), fit: BoxFit.fill),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                          //this right here
                                                          child: Container(
                                                            height: 200,
                                                            decoration: BoxDecoration(color: Color(0xFF0a0f32)),
                                                            child: Column(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    alignment: Alignment.centerRight,
                                                                    margin: EdgeInsets.only(right: 30, top: 20),
                                                                    child: Image(
                                                                      image: AssetImage("assets/images/close_1.png"),
                                                                      width: 20,
                                                                      height: 20,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      alignment: Alignment.center,
                                                                      margin: EdgeInsets.only(left: 30, top: 20),
                                                                      child: Text(
                                                                        "Do you want to add to cart ?",
                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Color(0xFFff5000)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  color: Colors.black,
                                                                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    getStringValuesSF().then((userid) => addcarttowishlist(snapshotitemlist[index]["id"], context));
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(bottom: 15),
                                                                    child: Image(
                                                                      image: AssetImage("assets/images/submit.png"),
                                                                      height: 60,
                                                                      width: 150,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    margin: EdgeInsets.only(left: 30, top: 20),
                                                    child: Image(image: AssetImage("assets/images/plus.png"), height: 25, width: 25, fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                          //this right here
                                                          child: Container(
                                                            height: 200,
                                                            decoration: BoxDecoration(color: Color(0xFF0a0f32)),
                                                            child: Column(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    alignment: Alignment.centerRight,
                                                                    margin: EdgeInsets.only(right: 30, top: 20),
                                                                    child: Image(
                                                                      image: AssetImage("assets/images/close_1.png"),
                                                                      width: 20,
                                                                      height: 20,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      alignment: Alignment.center,
                                                                      margin: EdgeInsets.only(left: 30, top: 20),
                                                                      child: Text(
                                                                        "Do you want to delete wishlist\nproduct ?",
                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Color(0xFFff5000)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  color: Colors.black,
                                                                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    getStringValuesSF().then((userid) => api.deletewishlist(userid, snapshotitemlist[index]["id"].toString(), context).then((value) => {getSWData(userid)}));
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(bottom: 15),
                                                                    child: Image(
                                                                      image: AssetImage("assets/images/submit.png"),
                                                                      height: 60,
                                                                      width: 150,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 20,
                                                    height: 25,
                                                    margin: EdgeInsets.only(right: 10, left: 30, top: 20),
                                                    child: Image(image: AssetImage("assets/images/icons_8_delete_bin_24.png"), height: 25, width: 20, fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 30),
                                                    child: Text(
                                                      snapshotitemlist[index]["product_name"],
                                                      style: TextStyle(fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(right: 30, top: 20),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(left: 30, top: 20, bottom: 10),
                                                    child: Image(image: NetworkImage(snapshotitemlist[index]["product_image"]), height: 80, width: 80, fit: BoxFit.scaleDown),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 30, top: 20),
                                                    child: Text(
                                                      "Quantity :",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Color(0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 30, top: 10),
                                                    child: Text(
                                                      "Amount :",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Color(0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 30, top: 10),
                                                    child: Text(
                                                      "Processing :",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Color(0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 30, top: 10),
                                                    child: Text(
                                                      "Gross Total :",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Color(0xFFff5000)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 90,
                                                    margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemBuilder: (context, index) {
                                                              return Container(
                                                                child: Text(
                                                                  atrlbl[index] + ": " + optlbl[index],
                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                                ),
                                                              );
                                                            },
                                                            itemCount: atrlbl.length,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 10, top: 10),
                                                    child: Text(
                                                      snapshotitemlist[index]["qty"],
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 10, top: 10),
                                                    child: Text(
                                                      snapshotitemlist[index]["amount"],
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 10, top: 10),
                                                    child: Text(
                                                      snapshotitemlist[index]["product_fee"],
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 10, top: 10),
                                                    child: Text(
                                                      grandtotal.toString(),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: snapshotitemlist.length,
                            ))
                      ],
                    )),
                  ))
                ],
              ),
            ],
          ),
          onWillPop: () async {
            return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Homescreen()));
          }),
    );
  }
}
