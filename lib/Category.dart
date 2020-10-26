import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/ScrollingText.dart';
import 'package:peg/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:peg/main.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CategoryFull(),
        ),
      ),
    );
  }
}

class CategoryFull extends StatefulWidget {
  @override
  _CategoryFullState createState() => _CategoryFullState();
}

final username_controller = TextEditingController();

TextStyle hintstyle =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 10.0, color: Colors.white);

class _CategoryFullState extends State<CategoryFull> {
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);
  String challengemail = "0";

  bool officon3 = true;
  bool onicon3 = false;

  List data = List(); //edited line
  List data2 = List(); //edited line

  Future<String> getSWData(String userid) async {
    var res = await http.get(
        Uri.encodeFull(RestDatasource.get_all_categories + "/" + userid),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody["category_list"];
    });

    return "Success";
  }

  Future<String> getSubCatData(String userid) async {
    var res = await http.get(
        Uri.encodeFull(RestDatasource.get_all_subcategories + userid),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody["subcategory_list"];
    });

    return "Success";
  }

  final entercategoryname = TextField(
    style: style,
    controller: username_controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(18),
      hintText: "Enter Category Name",
      border: InputBorder.none,
      hintStyle: hintstyle,
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF().then((value) => {
          getSWData(value),
        });
  }

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
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        15.0, 10.0, 0.0, 0.0),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/back_12.png'),
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0.0, 10.0, 0.0, 0.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Category",
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
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "My Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Bold',
                                  letterSpacing: 0.03,
                                  fontSize: 16.0,
                                  color: Colors.white),
                            ),
                          ),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                      //this right here
                                                      child: Container(
                                                        height: 250,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xFF0a0f32)),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              30,
                                                                          top:
                                                                              20),
                                                                  child: Text(
                                                                    "Category Name",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            'Roboto-Bold',
                                                                        letterSpacing:
                                                                            0.03,
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Color(
                                                                            0xFFff5000)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              30,
                                                                          top:
                                                                              20),
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        "assets/images/close_1.png"),
                                                                    width: 20,
                                                                    height: 20,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              height: 0.5,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 20,
                                                                      left: 20,
                                                                      top: 10),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Container(
                                                              color:
                                                                  Colors.black,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      30.0,
                                                                      20.0,
                                                                      30.0,
                                                                      0.0),
                                                              child: Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          20,
                                                                          10,
                                                                          20),
                                                                  decoration: new BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Color(0xFF00ffff))),
                                                                  child: Center(
                                                                    child:
                                                                        entercategoryname,
                                                                  )),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (username_controller
                                                                        .text
                                                                        .length ==
                                                                    0) {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Enter Category",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      fontSize:
                                                                          15,
                                                                      timeInSecForIos:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blue,
                                                                      textColor:
                                                                          Colors
                                                                              .white);
                                                                } else {
                                                                  getStringValuesSF().then((userid) => api
                                                                      .add_category(
                                                                          userid,
                                                                          username_controller
                                                                              .text,
                                                                          context)
                                                                      .then((value) =>
                                                                          getSWData(
                                                                              userid)));
                                                                }
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            15,
                                                                        top:
                                                                            20),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/submit.png"),
                                                                  height: 50,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                    "assets/images/add_category.png"),
                                                height: 50,
                                                width: 140,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/add_sub_category.png"),
                                              height: 50,
                                              width: 140,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                height: 120,
                              ),
                            ),
                          ),
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
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                "Sl.no.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Bold',
                                                    letterSpacing: 0.03,
                                                    fontSize: 10.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Category",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Bold',
                                                    letterSpacing: 0.03,
                                                    fontSize: 10.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Sub Category",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Bold',
                                                    letterSpacing: 0.03,
                                                    fontSize: 10.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Status",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Bold',
                                                    letterSpacing: 0.03,
                                                    fontSize: 10.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Roboto-Bold',
                                                    letterSpacing: 0.03,
                                                    fontSize: 10.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(20),
                                          itemBuilder: (_, index) => Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/ellipse_4222.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8, top: 10),
                                                    child: Text(
                                                      (index + 1).toString() +
                                                          ".",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Bold',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8, top: 23),
                                                    child: Text(
                                                      "Main Category",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Bold',
                                                          letterSpacing: 0.03,
                                                          fontSize: 12.0,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        left: 8, top: 23),
                                                    child: ScrollingText(
                                                      ratioOfBlankToScreen:
                                                          0.05,
                                                      text: data[index]["name"],
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Roboto-Bold',
                                                          letterSpacing: 0.03,
                                                          fontSize: 14.0,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 50,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        InkWell(
                                                          child: new Image(
                                                            image: AssetImage(
                                                                "assets/images/rounded_rectangle_2_copy.png"),
                                                            height: 50,
                                                            width: 65,
                                                          ),
                                                          onTap: () {
                                                            if (officon3) {
                                                              setState(() {
                                                                onicon3 = true;
                                                                officon3 =
                                                                    false;
                                                                challengemail =
                                                                    "1";
                                                              });
                                                            } else {
                                                              setState(() {
                                                                onicon3 = false;
                                                                officon3 = true;
                                                                challengemail =
                                                                    "0";
                                                              });
                                                            }
                                                          },
                                                        ),
                                                        Visibility(
                                                            visible: officon3,
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Row(
                                                                  children: [
                                                                    Image(
                                                                      image: AssetImage(
                                                                          "assets/images/ellipse_5_copy.png"),
                                                                      height:
                                                                          50,
                                                                      width: 20,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "on",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontFamily:
                                                                                'Roboto-Bold',
                                                                            letterSpacing:
                                                                                0.03,
                                                                            fontSize:
                                                                                10.0,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ))),
                                                        Visibility(
                                                            visible: onicon3,
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        "off",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontFamily:
                                                                                'Roboto-Bold',
                                                                            letterSpacing:
                                                                                0.03,
                                                                            fontSize:
                                                                                10.0,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              9),
                                                                      child:
                                                                          Image(
                                                                        image: AssetImage(
                                                                            "assets/images/ellipse_5_copy.png"),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            20,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ))),
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: 8, top: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 5, top: 23),
                                                        child: Image(
                                                          image: AssetImage(
                                                              "assets/images/edit_2222.png"),
                                                          width: 13,
                                                          height: 13,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0)),
                                                                  //this right here
                                                                  child:
                                                                      Container(
                                                                    height: 200,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                Color(0xFF0a0f32)),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.centerRight,
                                                                            margin:
                                                                                EdgeInsets.only(right: 30, top: 20),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage("assets/images/close_1.png"),
                                                                              width: 20,
                                                                              height: 20,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              alignment: Alignment.center,
                                                                              margin: EdgeInsets.only(left: 30, top: 20),
                                                                              child: Text(
                                                                                "Do you want to delete Category ?",
                                                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Color(0xFFff5000)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          color:
                                                                              Colors.black,
                                                                          margin: EdgeInsets.fromLTRB(
                                                                              30.0,
                                                                              5.0,
                                                                              30.0,
                                                                              0.0),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            api.deletecat(data[index]["id"].toString()).then((value) =>
                                                                                {
                                                                                  Navigator.pop(context),
                                                                                  getStringValuesSF().then((value) => getSWData(value))
                                                                                });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 15),
                                                                            child:
                                                                                Image(
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 5,
                                                                  top: 23),
                                                          child: Image(
                                                            image: AssetImage(
                                                                "assets/images/icons_8_delete_bin_24.png"),
                                                            width: 13,
                                                            height: 13,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          itemCount: data.length,
                                        )
                                      ],
                                    ))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {@required double strokeWidth,
      @required double radius,
      @required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

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
