import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/RestDatasource.dart';
import 'package:http/http.dart' as http;
import 'package:peg/homescreen.dart';

class ItemFull extends StatelessWidget {
  String id;

  ItemFull({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ItemDetail(id: id),
        ),
      ),
    );
  }
}

class ItemDetail extends StatefulWidget {
  String id;

  ItemDetail({Key key, @required this.id}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState(id);
}

class _ItemDetailState extends State<ItemDetail> {
  String id;
  String name;
  List images = List();

  _ItemDetailState(this.id);

  int _current = 0;
  RestDatasource api = new RestDatasource();
  Map<String, dynamic> snapshotitemlist = Map();

  List<dynamic> snapshotitemlistattl = List();
  List<Map<int, bool>> dynamicbools = List();
  List<dynamic> snaps = List();

  Map<int, bool> boolvalues = Map();

  void onChanged22(bool value) {
    setState(() {
      _mySelection2 = !_mySelection2;
    });
  }

  void onChanged(bool value, int index, int arrayindex , List<dynamic> list) {
    setState(() {
      if (value == true) {
        value = false;
      } else {
        value = true;
      }
      print("arraylistchange" + arrayindex.toString());
      print("optionname" + list[index]["option_label"].toString());

      dynamicbools[arrayindex][index] = value;
    });
  }

  var borderimg = new AssetImage('assets/images/rounded_rectangle_234.png');
  bool _mySelection = false;
  bool _mySelection2 = false;

  String _mySelection3;
  var back_1 = new AssetImage('assets/images/back_1.png');

  Widget _MyCheckBOXLISTview(BuildContext context, String type,
      List<dynamic> snapshotitemlist, int arrayindex) {
    print("arraytype" + dynamicbools.toString());

    if (type == "2") {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshotitemlist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChanged22(_mySelection2);
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
                          image: dynamicbools[arrayindex][index]
                              ? AssetImage("assets/images/ellipse_4_copy_4.png")
                              : AssetImage("assets/images/ellipse_4_copy.png")),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      snapshotitemlist[index]["option_label"],
                      style: TextStyle(
                          fontFamily: 'Roboto-Bold',
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (type == "1") {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshotitemlist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChanged(dynamicbools[arrayindex][index], index, arrayindex , snapshotitemlist);
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
                          image: dynamicbools[arrayindex][index]
                              ? AssetImage("assets/images/correct_5_copy_2.png")
                              : AssetImage(
                                  "assets/images/rounded_rectangle_3.png")),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      snapshotitemlist[index]["option_label"],
                      style: TextStyle(
                          fontFamily: 'Roboto-Bold',
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: borderimg,
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30.0, left: 20),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Color(0xFF0a0f32),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 0.0,
                              hint: Text(
                                "Please select main category",
                                style: style,
                              ),
                              isExpanded: true,
                              style: style,
                              value: _mySelection3,
                              onChanged: (newVal) {
                                setState(() {
                                  _mySelection3 = newVal;
                                });
                              },
                              items: snapshotitemlist.map((item) {
                                return DropdownMenuItem(
                                  child: new Text(
                                    item['option_label'],
                                    style: style,
                                  ),
                                  value: item['option_label'],
                                );
                              }).toList(),
                            ),
                          )),
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
      );
    }
  }

  Future<String> getSWData(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.view_product + id),
        headers: {"Accept": "application/json"});

    setState(() {
      snapshotitemlist.addAll(
          Map<String, dynamic>.from(json.decode(res.body)["product_data"]));
      images = snapshotitemlist["prdct_img_arr"];

      snapshotitemlistattl = snapshotitemlist["attribute_list"];

      for (int i = 0; i < snapshotitemlistattl.length; i++) {
        List<dynamic> tempsnap = snapshotitemlistattl[i]["option_list"];
        Map<int, bool> boolvalues = Map();
        for (int j = 0; j < tempsnap.length; j++) {
          boolvalues[j] = false;
        }
        dynamicbools.add(boolvalues);
      }
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData(this.id);
  }

  @override
  Widget build(BuildContext context) {
    if (snapshotitemlist.length < 1) {
      return Container(
        color: Color(0xFF0a0f32),
        child: Center(
          child: Loading(
              indicator: BallPulseIndicator(),
              size: 100.0,
              color: Color(0xFF6ae7e0)),
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
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/back_12.png'),
                                    height: 30,
                                    width: 30,
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                            color: Color(0xFF0a0f32),
                            height: 80,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 50, right: 50),
                                    child: Text(
                                      snapshotitemlist["product_detail"]
                                          ["name"],
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Bold',
                                          fontSize: 16.0,
                                          color: Colors.white),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 50, left: 50, top: 20, bottom: 20),
                                  color: Colors.orange,
                                  height: 2,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      CarouselSlider(
                                        items: images.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Column(
                                                children: [
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0,
                                                              vertical: 10.0),
                                                      child: Image(
                                                        image: NetworkImage(i),
                                                        fit: BoxFit.cover,
                                                        height: 200,
                                                      )),
                                                ],
                                              );
                                            },
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 220,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: images.map((url) {
                                          int index = images.indexOf(url);
                                          return Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 2.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: _current == index
                                                    ? DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/dot1.png"))
                                                    : DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/dot2.png"))),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 50, right: 50),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0a0f32),
                                      border:
                                          Border.all(color: Color(0xFF6ae7e0)),
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 100,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                          left: 30,
                                        ),
                                        child: Text(
                                          new String.fromCharCodes(
                                                  new Runes('\u0024')) +
                                              snapshotitemlist["product_detail"]
                                                  ["price"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto-Bold',
                                              letterSpacing: 0.4,
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 30,
                                                width: 30,
                                                color: Colors.orange,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/images/minus.png"),
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Container(
                                              width: 60,
                                              height: 30,
                                              margin: EdgeInsets.only(
                                                  right: 5, left: 5),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "0",
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Bold',
                                                    fontSize: 16.0,
                                                    color: Colors.white),
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0)),
                                            ),
                                            Container(
                                                height: 30,
                                                width: 30,
                                                color: Colors.orange,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/images/add.png"),
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 50),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/images/cart.png"),
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/images/post.png"),
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        right: 30.0, left: 30.0, top: 20.0),
                                    color: Color(0xFF0a0f32),
                                    child: Container(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            snapshotitemlist["attribute_list"]
                                                .length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  snapshotitemlistattl[index]
                                                      ["title"],
                                                  style: TextStyle(
                                                      letterSpacing: 0.02,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto-Bold',
                                                      fontSize: 15.0,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              _MyCheckBOXLISTview(
                                                  context,
                                                  snapshotitemlistattl[index]
                                                      ["type"],
                                                  snapshotitemlistattl[index]
                                                      ["option_list"],
                                                  index),
                                            ],
                                          );
                                        },
                                      ),
                                    )),
                                Container(
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 50),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/group_2_copy_2_2.png"),
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/group_2_copy_2.png"),
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Text(
                                          "About Product : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto-Medium',
                                              letterSpacing: 0.03,
                                              fontSize: 14.0,
                                              color: Color(0xFFff5000)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          "All different colors.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto-Medium',
                                              letterSpacing: 0.03,
                                              fontSize: 14.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 30, left: 30, bottom: 30),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF0a0f32),
                                      border:
                                          Border.all(color: Color(0xFFff5000)),
                                      borderRadius: BorderRadius.circular(5.0)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
