import 'dart:collection';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/Add_to_cart.dart';
import 'package:peg/RestDatasource.dart';
import 'package:http/http.dart' as http;
import 'package:peg/homescreen.dart';
import 'package:peg/main.dart';
import 'package:peg/whishlist.dart';

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

final username_controller = TextEditingController();

TextStyle hintstyle = TextStyle(fontFamily: 'Roboto-Bold', fontSize: 10.0, color: Colors.white);

class _ItemDetailState extends State<ItemDetail> {
  String id;
  String name;
  List images = List();

  String userid;

  final entercategoryname = TextField(
    style: style,
    controller: username_controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(18),
      hintText: "Enter Tag",
      border: InputBorder.none,
      hintStyle: hintstyle,
    ),
  );

  var ref_seller_id;

  int qty = 0;

  String Custom_Tag = "";

  var customvis = false;

  var product_image;

  var product_id;

  var price;

  var product_fee;

  var int_fee;

  var product_name;

  int realqty = 0;

  String selvertion = "";
  String extraamount = "";

  Map<String, String> apimap = new Map();

  _ItemDetailState(this.id);

  int _current = 0;
  RestDatasource api = new RestDatasource();
  Map<String, dynamic> snapshotitemlist = Map();

  List<dynamic> snapshotitemlistattl = List();
  List<Map<int, bool>> dynamicbools = List();
  List<dynamic> snaps = List();

  Map<int, bool> boolvalues = Map();

  void onChanged(bool value, int index, int arrayindex, List<dynamic> list, String attribute_id) {
    setState(() {
      if (value == true) {
        value = false;
      } else {
        value = true;
      }

      for (int i = 0; i < dynamicbools[arrayindex].length; i++) {
        if (i == index) {
          dynamicbools[arrayindex][index] = value;
        } else {
          dynamicbools[arrayindex][i] = false;
        }
      }

      String extra;
      String selvartion;

      apimap.forEach((key, value) {
        if (key.contains("[") && key.contains("extra_amount")) {
          const start = "[";
          const end = "]";
          final startIndex = key.indexOf(start);
          final endIndex = key.indexOf(end, startIndex + start.length);

          if (key.substring(startIndex + start.length, endIndex) == attribute_id) {
            extra = key;
          }
        }
        if (key.contains("[") && key.contains("sel_variation")) {
          const start = "[";
          const end = "]";
          final startIndex = key.indexOf(start);
          final endIndex = key.indexOf(end, startIndex + start.length);

          if (key.substring(startIndex + start.length, endIndex) == attribute_id) {
            selvartion = key;
          }
        }
      });

      apimap.remove(extra);
      apimap.remove(selvartion);

      String optionid = list[index]["option_id"];

      selvertion = "sel_variation" + "[" + attribute_id + "]" + "[0]";

      apimap[selvertion] = optionid;

      String extraamountt = "";

      for (int i = 0; i < list.length; i++) {
        if (optionid == list[i]["option_id"]) {
          extraamountt = list[i]["extra_amount"];
        }
      }

      extraamount = "extra_amount" + "[" + attribute_id + "]" + "[" + optionid + "]";

      apimap[extraamount] = extraamountt;
    });
  }

  var borderimg = new AssetImage('assets/images/rounded_rectangle_234.png');

  String _mySelection3;
  var back_1 = new AssetImage('assets/images/back_1.png');

  Widget _MyCheckBOXLISTview(String attribute_id, BuildContext context, String type, List<dynamic> snapshotitemlist, int arrayindex) {
    if (type == "2") {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshotitemlist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChanged(dynamicbools[arrayindex][index], index, arrayindex, snapshotitemlist, attribute_id);
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
                      child: Image(image: dynamicbools[arrayindex][index] ? AssetImage("assets/images/ellipse_4_copy_4.png") : AssetImage("assets/images/ellipse_4_copy.png")),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      snapshotitemlist[index]["option_label"],
                      style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
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
              onChanged(dynamicbools[arrayindex][index], index, arrayindex, snapshotitemlist, attribute_id);
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
                      child: Image(image: dynamicbools[arrayindex][index] ? AssetImage("assets/images/correct_5_copy_2.png") : AssetImage("assets/images/rounded_rectangle_3.png")),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      snapshotitemlist[index]["option_label"],
                      style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
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

                                  String extra;
                                  String selvartion;

                                  apimap.forEach((key, value) {
                                    if (key.contains("[") && key.contains("extra_amount")) {
                                      const start = "[";
                                      const end = "]";
                                      final startIndex = key.indexOf(start);
                                      final endIndex = key.indexOf(end, startIndex + start.length);
                                      if (key.substring(startIndex + start.length, endIndex) == attribute_id) {
                                        extra = key;
                                      }
                                    }
                                    if (key.contains("[") && key.contains("sel_variation")) {
                                      const start = "[";
                                      const end = "]";
                                      final startIndex = key.indexOf(start);
                                      final endIndex = key.indexOf(end, startIndex + start.length);
                                      if (key.substring(startIndex + start.length, endIndex) == attribute_id) {
                                        selvartion = key;
                                      }
                                    }
                                  });

                                  apimap.remove(extra);
                                  apimap.remove(selvartion);

                                  selvertion = "sel_variation" + "[" + snapshotitemlist[arrayindex]["attr_id"] + "]" + "[0]";

                                  apimap[selvertion] = _mySelection3;

                                  String extraamountt = "";

                                  for (int i = 0; i < snapshotitemlist.length; i++) {
                                    if (_mySelection3 == snapshotitemlist[i]["option_id"]) {
                                      extraamountt = snapshotitemlist[i]["extra_amount"];
                                    }
                                  }

                                  extraamount = "extra_amount" + "[" + snapshotitemlist[arrayindex]["attr_id"] + "]" + "[" + _mySelection3 + "]";

                                  apimap[extraamount] = extraamountt;
                                });
                              },
                              items: snapshotitemlist.map((item) {
                                return DropdownMenuItem(
                                  child: new Text(
                                    item['option_label'],
                                    style: style,
                                  ),
                                  value: item['option_id'],
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
    var res = await http.get(Uri.encodeFull(RestDatasource.view_product + id), headers: {"Accept": "application/json"});

    getStringValuesSF().then((value) => userid = value);

    setState(() {
      snapshotitemlist.addAll(Map<String, dynamic>.from(json.decode(res.body)["product_data"]));
      images = snapshotitemlist["prdct_img_arr"];
      ref_seller_id = snapshotitemlist["product_detail"]["seller_id"];
      qty = int.parse(snapshotitemlist["product_detail"]["qty"].toString());

      if (snapshotitemlist["product_detail"]["is_customizable"] == "1") {
        setState(() {
          customvis = true;
        });
      }
      product_image = snapshotitemlist["product_detail"]["image"];
      product_id = snapshotitemlist["product_id"];
      price = snapshotitemlist["product_detail"]["price"];
      product_fee = snapshotitemlist["product_detail"]["fee"];
      int_fee = snapshotitemlist["product_detail"]["int_fee"];
      product_name = snapshotitemlist["product_detail"]["name"];

      getStringValuesSF().then((value) => {
            userid = value,
            apimap["user_id"] = value,
            apimap["ref_seller_id"] = ref_seller_id.toString(),
            apimap["product_image"] = product_image.toString(),
            apimap["product_id"] = product_id.toString(),
            apimap["amount"] = price.toString(),
            apimap["product_fee"] = product_fee.toString(),
            apimap["int_fee"] = int_fee.toString(),
            apimap["product_name"] = product_name.toString(),
          });

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
          child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: Color(0xFF6ae7e0)),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => Homescreen(),
                                    ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                                    child: Image(
                                      image: AssetImage('assets/images/back_12.png'),
                                      height: 30,
                                      width: 30,
                                    ),
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
                                    margin: EdgeInsets.only(left: 50, right: 50),
                                    child: Text(
                                      snapshotitemlist["product_detail"]["name"],
                                      style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
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
                                                      width: MediaQuery.of(context).size.width,
                                                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: images.map((url) {
                                          int index = images.indexOf(url);
                                          return Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                            decoration: BoxDecoration(shape: BoxShape.circle, image: _current == index ? DecorationImage(image: AssetImage("assets/images/dot1.png")) : DecorationImage(image: AssetImage("assets/images/dot2.png"))),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                                  decoration: BoxDecoration(color: Color(0xFF0a0f32), border: Border.all(color: Color(0xFF6ae7e0)), borderRadius: BorderRadius.circular(5.0)),
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
                                          new String.fromCharCodes(new Runes('\u0024')) + snapshotitemlist["product_detail"]["price"],
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.4, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (realqty > 0) {
                                                    realqty--;
                                                    apimap["qty"] = realqty.toString();
                                                  }
                                                });
                                              },
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  color: Colors.orange,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Image(
                                                      image: AssetImage("assets/images/minus.png"),
                                                      height: 20,
                                                      width: 20,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                              width: 60,
                                              height: 30,
                                              margin: EdgeInsets.only(right: 5, left: 5),
                                              alignment: Alignment.center,
                                              child: Text(
                                                realqty.toString(),
                                                style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
                                              ),
                                              decoration: BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(2.0)),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (realqty < qty) {
                                                    realqty++;
                                                    apimap["qty"] = realqty.toString();
                                                  }
                                                });
                                              },
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  color: Colors.orange,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Image(
                                                      image: AssetImage("assets/images/add.png"),
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 50),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(right: 5),
                                                    child: Image(
                                                      image: AssetImage("assets/images/cart.png"),
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (Custom_Tag == "" && customvis) {
                                                      apimap["Custom_Tag"] = "PRO ESPORTS GAMiNG";
                                                    } else if (Custom_Tag != "" && customvis) {
                                                      apimap["Custom_Tag"] = Custom_Tag.toString();
                                                    }

                                                    api.addtowishlist(apimap).then(
                                                          (value) => getStringValuesSF().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Wishlist()))),
                                                        );
                                                  },
                                                  child: Container(
                                                    child: Image(
                                                      image: AssetImage("assets/images/post.png"),
                                                      height: 25,
                                                      width: 25,
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
                                      right: 30.0,
                                      left: 30.0,
                                      top: 20.0,
                                    ),
                                    color: Color(0xFF0a0f32),
                                    child: Container(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshotitemlist["attribute_list"].length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  snapshotitemlistattl[index]["title"],
                                                  style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
                                                ),
                                              ),
                                              _MyCheckBOXLISTview(snapshotitemlistattl[index]["attribute_id"], context, snapshotitemlistattl[index]["type"], snapshotitemlistattl[index]["option_list"], index),
                                            ],
                                          );
                                        },
                                      ),
                                    )),
                                Container(
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: customvis,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                    //this right here
                                                    child: Container(
                                                      height: 250,
                                                      decoration: BoxDecoration(color: Color(0xFF0a0f32)),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(left: 30, top: 20),
                                                                child: Text(
                                                                  "Category Name",
                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.only(right: 30, top: 20),
                                                                  child: Image(
                                                                    image: AssetImage("assets/images/close_1.png"),
                                                                    width: 20,
                                                                    height: 20,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              )
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
                                                                  child: entercategoryname,
                                                                )),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              if (username_controller.text.length == 0) {
                                                                Fluttertoast.showToast(msg: "Enter Tag", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                                                              } else {
                                                                Custom_Tag = username_controller.text;
                                                                Navigator.pop(context);
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.only(bottom: 12, top: 20),
                                                              child: Image(
                                                                image: AssetImage("assets/images/submit.png"),
                                                                height: 50,
                                                                width: 120,
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
                                            margin: EdgeInsets.only(top: 20),
                                            child: Image(
                                              image: AssetImage("assets/images/group_2_copy_2_2.png"),
                                              width: 200,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (Custom_Tag == "" && customvis) {
                                      apimap["Custom_Tag"] = "PRO ESPORTS GAMiNG";
                                    } else if (Custom_Tag != "" && customvis) {
                                      apimap["Custom_Tag"] = Custom_Tag.toString();
                                    }

                                    api.addtocart(apimap).then(
                                          (value) => getStringValuesSF().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (BuildContext context) => Addtocart(
                                                    id: value,
                                                  )))),
                                        );
                                  },
                                  child: Container(
                                    child: Image(
                                      image: AssetImage("assets/images/group_2_copy_2.png"),
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 20),
                                        child: Text(
                                          "About Product : ",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 14.0, color: Color(0xFFff5000)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          "All different colors.",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 14.0, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 30, left: 30, bottom: 30),
                                  decoration: BoxDecoration(color: Color(0xFF0a0f32), border: Border.all(color: Color(0xFFff5000)), borderRadius: BorderRadius.circular(5.0)),
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
            return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Homescreen()));
          }),
    );
  }
}
