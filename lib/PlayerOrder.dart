import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/PlayerorderDetail.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/main.dart';
import 'package:http/http.dart' as http;

import 'Category.dart';
import 'PaymentScreen.dart';

class PlayerOrder extends StatelessWidget {
  String userid;

  PlayerOrder(this.userid);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: PlayerOrderFull(userid),
      ),
    ));
  }
}

class PlayerOrderFull extends StatefulWidget {
  String userid;

  PlayerOrderFull(this.userid);

  @override
  _PlayerOrderFullState createState() => _PlayerOrderFullState(userid);
}

final edit_controller22 = TextEditingController();

class _PlayerOrderFullState extends State<PlayerOrderFull> {
  List<Map<String, dynamic>> snapshotitemlist;

  String userid;

  _PlayerOrderFullState(this.userid);

  Future<String> getSWData(String id) async {
    var res = await http.get(
        Uri.encodeFull(RestDatasource.get_player_order + id),
        headers: {"Accept": "application/json"});

    getStringValuesSF().then((value) => {userid = value, print(value)});

    setState(() {
      snapshotitemlist =
          List<Map<String, dynamic>>.from(json.decode(res.body)['order_list']);
      print(snapshotitemlist);
    });
    return "Success";
  }

  final editcategoryname22 = TextField(
    style: style,
    controller: edit_controller22,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(18),
      hintText: "Update Tracking ID",
      border: InputBorder.none,
      hintStyle: hintstyle,
    ),
  );

  @override
  void initState() {
    super.initState();
    this.getSWData(this.userid);
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
                          child:GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Homescreen(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                              child: Image(
                                image: AssetImage('assets/images/back_12.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                          )
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Player Orders",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Bold',
                                  letterSpacing: 0.03,
                                  fontSize: 12.0,
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
                            String order_status =
                                snapshotitemlist[index]["order_status"];
                            bool view;
                            bool edit;
                            bool delete;

                            if (order_status == "completed") {
                              edit = true;
                              view = true;
                              delete = false;
                            } else if (order_status == "placed") {
                              edit = true;
                              view = true;
                              delete = true;
                            } else {
                              edit = false;
                              view = true;
                              delete = false;
                            }

                            return Container(
                              margin: EdgeInsets.only(
                                  right: 30, left: 30, bottom: 10),
                              child: Stack(
                                children: [
                                  Image(
                                      image: AssetImage(
                                          "assets/images/ellipse_4.png"),
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
                                                    snapshotitemlist[index]
                                                        ["id"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Roboto-Medium',
                                                        letterSpacing: 0.03,
                                                        fontSize: 12.0,
                                                        color:
                                                            Color(0xFFff5000)),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 6, top: 6),
                                                  child: Text(
                                                    snapshotitemlist[index]
                                                            ["created_at"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Roboto-Medium',
                                                        letterSpacing: 0.03,
                                                        fontSize: 12.0,
                                                        color:
                                                            Color(0xFFff5000)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 80,),
                                                    child: Text(
                                                      "Tracking ID :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
                                                          color: Color(
                                                              0xFFff5000)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 80, top: 10),
                                                    child: Text(
                                                      "Total :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
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
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFff5000),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    3))),
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    child: Text(
                                                      snapshotitemlist[index]
                                                              ["tracking_id"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    child: Text(
                                                      snapshotitemlist[index]
                                                              ["grand_total"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
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
                                                onTap: () => {
                                                      getStringValuesSF().then((value) => Navigator
                                                              .of(context)
                                                          .pushReplacement(MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  PlayerorderDetail(
                                                                      snapshotitemlist[
                                                                              index]
                                                                          [
                                                                          "user_id"],
                                                                      snapshotitemlist[
                                                                              index]
                                                                          [
                                                                          "id"])))),
                                                    },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/images/view_order_details.png"),
                                                        width: 150,
                                                        height: 50,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Visibility(
                                                          visible: delete,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Dialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0)),
                                                                      //this right here
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            200,
                                                                        decoration:
                                                                            BoxDecoration(color: Color(0xFF0a0f32)),
                                                                        child:
                                                                            Column(
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
                                                                                    "Do you want to cancel order ?",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
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
                                                                                getStringValuesSF().then((userid) => api.cancelorder(snapshotitemlist[index]["id"], context)).then((value) => getSWData(userid));
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
                                                            child: Container(
                                                              child: Image(
                                                                image: AssetImage(
                                                                    "assets/images/close_1.png"),
                                                                width: 20,
                                                                height: 20,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                            visible: view,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () => {
                                                                getStringValuesSF().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                    builder: (BuildContext context) => PlayerorderDetail(
                                                                        snapshotitemlist[index]
                                                                            [
                                                                            "user_id"],
                                                                        snapshotitemlist[index]
                                                                            [
                                                                            "id"])))),
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            5,
                                                                        left:
                                                                            5),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/correct.png"),
                                                                  width: 20,
                                                                  height: 20,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )),
                                                        Visibility(
                                                            visible: edit,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Dialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0)),
                                                                        //this right here
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              250,
                                                                          decoration:
                                                                              BoxDecoration(color: Color(0xFF0a0f32)),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(left: 30, top: 20),
                                                                                    child: Text(
                                                                                      "Tracking ID ",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(right: 30, top: 20),
                                                                                    child: Image(
                                                                                      image: AssetImage("assets/images/close_1.png"),
                                                                                      width: 20,
                                                                                      height: 20,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Container(
                                                                                height: 0.5,
                                                                                margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                                                                                color: Colors.white,
                                                                              ),
                                                                              Container(
                                                                                color: Colors.black,
                                                                                margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                                                                                child: Container(
                                                                                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                                                                    decoration: new BoxDecoration(border: Border.all(color: Color(0xFF00ffff))),
                                                                                    child: Center(
                                                                                      child: editcategoryname22,
                                                                                    )),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  if (edit_controller22.text.length == 0) {
                                                                                    Fluttertoast.showToast(msg: "Enter Tacking ID", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                                                                                  } else {
                                                                                    getStringValuesSF().then((userid) => api.update_tacking_infoAPI(snapshotitemlist[index]["id"], edit_controller22.text, snapshotitemlist[index]["ref_seller_id"], snapshotitemlist[index]["grand_total"], snapshotitemlist[index]["user_id"], context)).then((value) => getSWData(userid));
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  margin: EdgeInsets.only(bottom: 15, top: 20),
                                                                                  child: Image(
                                                                                    image: AssetImage("assets/images/submit.png"),
                                                                                    height: 50,
                                                                                    width: 100,
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
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/edit.png"),
                                                                  width: 20,
                                                                  height: 20,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          },
                          itemCount: snapshotitemlist.length,
                        ),
                      ],
                    )),
                  )),
                ],
              ),
            ],
          ),
          onWillPop: () async {
            return Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Homescreen()));
          }),
    );
  }
}
