import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/Add_Product.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peg/main.dart';
import 'package:http/http.dart' as http;

class SellProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SellProductPAGE(),
        ),
      ),
    );
  }
}

class SellProductPAGE extends StatefulWidget {
  @override
  _SellProductPAGEState createState() => _SellProductPAGEState();
}

var entervalue = TextEditingController();

List<String> list = ["Fix Amount", "Percentage"];
TextStyle hintstyle = TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white);

class _SellProductPAGEState extends State<SellProductPAGE> {
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);

  List<dynamic> snapshotproductlist;
  var borderimg = new AssetImage('assets/images/rounded_rectangle_234.png');
  String _mySelection;

  var back_1 = new AssetImage('assets/images/back_1.png');

  Future _showDialog22(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF0a0f32),
          content: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(color: Color(0xFF0a0f32)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 20),
                          child: Text(
                            "Shipping Tax",
                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 20),
                            child: Image(
                              image: AssetImage("assets/images/close_1.png"),
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.5,
                      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                      color: Colors.white,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text(
                        'International Fee',
                        style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.black,
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                                        margin: EdgeInsets.only(right: 10.0, left: 10),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Theme(
                                              data: Theme.of(context).copyWith(
                                                canvasColor: Color(0xFF0a0f32),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  iconSize: 0.0,
                                                  isExpanded: true,
                                                  hint: Text(
                                                    "Please select international tax",
                                                    style: style,
                                                  ),
                                                  style: style,
                                                  onChanged: (newVal) {
                                                    setState(() {
                                                      _mySelection = newVal;
                                                    });
                                                  },
                                                  value: _mySelection,
                                                  items: list.map((String item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item,
                                                        style: style,
                                                      ),
                                                      value: item,
                                                    );
                                                  }).toList(),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(right: 10.0),
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
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: new BoxDecoration(border: Border.all(color: Color(0xFF00ffff))),
                                child: Center(
                                  child: entercategoryname,
                                )),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        String type = "";

                        if (_mySelection == "Fix Amount" && entervalue.text.length != 0) {
                          type = "1";

                          getStringValuesSF().then((value) => api.updateinternationaltax(value, type, entervalue.text, context));
                        } else if (_mySelection == "Percentage" && entervalue.text.length != 0) {
                          type = "2";

                          getStringValuesSF().then((value) => api.updateinternationaltax(value, type, entervalue.text, context));
                        } else {
                          Fluttertoast.showToast(msg: "Please select international tax", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image(
                          image: AssetImage("assets/images/submit.png"),
                          height: 40,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future _showDialog(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF0a0f32),
          content: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(color: Color(0xFF0a0f32)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 20),
                          child: Text(
                            "Shipping Tax",
                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 20),
                            child: Image(
                              image: AssetImage("assets/images/close_1.png"),
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.5,
                      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                      color: Colors.white,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text(
                        'Local Fee',
                        style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.black,
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                                        margin: EdgeInsets.only(right: 10.0, left: 10),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Theme(
                                              data: Theme.of(context).copyWith(
                                                canvasColor: Color(0xFF0a0f32),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  iconSize: 0.0,
                                                  isExpanded: true,
                                                  hint: Text(
                                                    "Please select tax",
                                                    style: style,
                                                  ),
                                                  style: style,
                                                  onChanged: (newVal) {
                                                    setState(() {
                                                      _mySelection = newVal;
                                                    });
                                                  },
                                                  value: _mySelection,
                                                  items: list.map((String item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item,
                                                        style: style,
                                                      ),
                                                      value: item,
                                                    );
                                                  }).toList(),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(right: 10.0),
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
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: new BoxDecoration(border: Border.all(color: Color(0xFF00ffff))),
                                child: Center(
                                  child: entercategoryname,
                                )),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        String type = "";

                        if (_mySelection == "Fix Amount" && entervalue.text.length != 0) {
                          type = "1";

                          getStringValuesSF().then((value) => api.updatelocaltax(value, type, entervalue.text, context));
                        } else if (_mySelection == "Percentage" && entervalue.text.length != 0) {
                          type = "2";

                          getStringValuesSF().then((value) => api.updatelocaltax(value, type, entervalue.text, context));
                        } else {
                          Fluttertoast.showToast(msg: "Please select tax", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image(
                          image: AssetImage("assets/images/submit.png"),
                          height: 40,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  final entercategoryname = TextField(
    style: style,
    keyboardType: TextInputType.number,
    controller: entervalue,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(15),
      hintText: "Value",
      border: InputBorder.none,
      hintStyle: hintstyle,
    ),
  );

  Future<String> getProductList(String userid) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_products + "/" + userid), headers: {"Accept": "application/json", "content-type": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      if (snapshotproductlist != null) {
        snapshotproductlist.clear();
      }
      snapshotproductlist = resBody["product_list"];
    });

    return "Success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF().then((value) => this.getProductList(value));
  }

  @override
  Widget build(BuildContext context) {
    print(snapshotproductlist);

    if (snapshotproductlist == null) {
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
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
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
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Sell Products",
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
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "My Selling Products",
                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 14.0, color: Colors.white),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomPaint(
                                painter: _GradientPainter(
                                  strokeWidth: 1,
                                  radius: 10,
                                  gradient: LinearGradient(
                                    colors: [color2, color3],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                builder: (context) => AddproductFull(),
                                              ));
                                            },
                                            child: Image(
                                              image: AssetImage("assets/images/invalid_name.png"),
                                              height: 80,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            child: Text(
                                              "Add product",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20, top: 10),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    _showDialog(context);
                                                  },
                                                  child: Container(
                                                    child: Image(
                                                      image: AssetImage("assets/images/local_tax.png"),
                                                      height: 50,
                                                      width: 140,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    _showDialog22(context);
                                                  },
                                                  child: Container(
                                                    child: Image(
                                                      image: AssetImage("assets/images/international_tax.png"),
                                                      height: 50,
                                                      width: 140,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                  height: 120,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(20),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (_, index) => Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 5, top: 5),
                                            child: Image(
                                              image: AssetImage("assets/images/edit_2.png"),
                                              height: 15,
                                              width: 15,
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
                                                                    "Do you want to delete product ?",
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
                                                                api.deleteproduct(snapshotproductlist[index]["id"].toString()).then((value) => {Navigator.pop(context), getStringValuesSF().then((value) => getProductList(value))});
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
                                              margin: EdgeInsets.only(right: 5, top: 5),
                                              child: Image(
                                                image: AssetImage("assets/images/icons_8_delete_bin_24.png"),
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          snapshotproductlist[index]["name"],
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 8.0, color: Color(0xFF0a0f32)),
                                        ),
                                      ),
                                      Card(
                                        elevation: 5.0,
                                        margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "Qty-" + snapshotproductlist[index]["qty"],
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 8.0, color: Color(0xFF0a0f32)),
                                              ),
                                            ),
                                            Align(
                                              child: Container(
                                                height: 100,
                                                margin: EdgeInsets.only(bottom: 5.0),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshotproductlist[index]["image"]))),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(left: 5.0),
                                                      child: Text(
                                                        "Amount :",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 8.0, color: Color(0xFF0a0f32)),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        new String.fromCharCodes(new Runes('\u0024')) + snapshotproductlist[index]["price"],
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 8.0, color: Color(0xFF8616d3)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Fee :",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 8.0, color: Color(0xFF0a0f32)),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(right: 5.0),
                                                      child: Text(
                                                        new String.fromCharCodes(new Runes('\u0024')) + snapshotproductlist[index]["fee"],
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 8.0, color: Color(0xFF8616d3)),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                                ),
                                itemCount: snapshotproductlist.length,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  )
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

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({@required double strokeWidth, @required double radius, @required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

Future<String> getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return
  return prefs.getString('userID');
}


