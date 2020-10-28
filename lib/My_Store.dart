import 'dart:convert';
import 'dart:io';

/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';

import 'package:http/http.dart' as http;
import 'package:peg/main.dart';

class MyStoreLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyStore(),
        ),
      ),
    );
  }
}

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

List<OrdinalSales> list = new List();

class _MyStoreState extends State<MyStore> {
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);
  final username_controller = TextEditingController();

  TextStyle hintstyle = TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white);
  bool click = false;

  var borderimg = new AssetImage('assets/images/borderimg.png');
  Map<String, dynamic> map;

  Map<String, dynamic> currentlevel = new Map();

  String uploadimageString = "No file Chosen";

  Future<String> getSWData(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_store_overview + id), headers: {"Accept": "application/json", "content-type": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      map = resBody["store_data"];
      username_controller.text = map["store_link"];
    });

    return "Success";
  }

  File file;
  var serverReceiverPath = RestDatasource.update_store_banner;

  Future<String> uploadImage(filename, useris, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.cyan,
              strokeWidth: 5,
            ),
          );
        });

    var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath));
    request.files.add(await http.MultipartFile.fromString('user_id', useris));
    request.files.add(await http.MultipartFile.fromPath('banner_image', filename));
    var res = await request.send();

    if (res.statusCode == 200) {
      getSWData(useris);
      Fluttertoast.showToast(msg: "Upload Successfully", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
    } else {
      Navigator.pop(context);
    }

    print(res.statusCode);
    return res.reasonPhrase;
  }

  File uploadimage; //variable for choosed file

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
      uploadimageString = uploadimage.path.toString();
    });
  }

  Future<String> getCurrentLevel(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_store_level + id), headers: {"Accept": "application/json", "content-type": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      currentlevel.clear();
      currentlevel = resBody["data"];
      for (int i = 0; i < currentlevel["user_level_data_array"].length; i++) {
        int position = i + 1;
        int value = int.parse(currentlevel["user_level_data_array"][i].toString());
        list.add(new OrdinalSales("Level " + position.toString(), value));
      }
    });

    return "Success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getStringValuesSF().then((value) => {this.getCurrentLevel(value), this.getSWData(value)});
  }

  @override
  Widget build(BuildContext context) {
    if (map == null) {
      return Container(
        color: Color(0xFF0a0f32),
        child: Center(
          child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: color3),
        ),
      );
    } else if (currentlevel.isEmpty) {
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
                                  "My Store",
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
                        margin: EdgeInsets.only(left: 30),
                        child: Text(
                          "Store Details",
                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 30, top: 20),
                              child: Column(
                                children: [
                                  CustomPaint(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10, top: 5),
                                          child: Text(
                                            map["total_gross_selling"].toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/save_money_white.png"))),
                                    ),
                                    painter: _GradientPainter(
                                      strokeWidth: 1,
                                      radius: 10,
                                      gradient: LinearGradient(
                                        colors: [color2, color3],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Gross Selling",
                                      style: TextStyle(fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  CustomPaint(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10, top: 5),
                                          child: Text(
                                            map["total_items_sold"].toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/shopping_bag_white.png"))),
                                      height: 100,
                                      width: 100,
                                    ),
                                    painter: _GradientPainter(
                                      strokeWidth: 1,
                                      radius: 10,
                                      gradient: LinearGradient(
                                        colors: [color2, color3],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Sold Items",
                                      style: TextStyle(fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 20, right: 30),
                              child: Column(
                                children: [
                                  CustomPaint(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10, top: 5),
                                          child: Text(
                                            map["total_orders"].toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/sold_items_white.png"))),
                                      height: 100,
                                      width: 100,
                                    ),
                                    painter: _GradientPainter(
                                      strokeWidth: 1,
                                      radius: 10,
                                      gradient: LinearGradient(
                                        colors: [color2, color3],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Order Received",
                                      style: TextStyle(fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      Container(
                        height: 0.5,
                        margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                        height: 80,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 27),
                                child: Text(
                                  currentlevel["current_level"]["level"].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 16.0, color: Color(0xFFff5000)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Current Level",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 16.0, color: Color(0xFF4edbfb)),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Level : " + currentlevel["current_level"]["level_title"].toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Color(0xFFff5000)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 27),
                                child: Text(
                                  currentlevel["current_level"]["level"].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 16.0, color: Color(0xFFff5000)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/group_9.png"))),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(right: 30, left: 30, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 30, top: 10),
                              child: Text(
                                "Current Levels",
                                style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (click) {
                                    click = false;
                                  } else {
                                    click = true;
                                  }
                                });
                              },
                              child: Container(
                                width: 100,
                                height: 60,
                                alignment: Alignment.center,
                                child: Container(
                                  child: Image(
                                    image: AssetImage("assets/images/list.png"),
                                    width: 100,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: click,
                        child: levellist(currentlevel["levels"]),
                      ),
                      Container(height: 150, width: 300, child: CustomFontSizeAndColor(_createSampleData())),
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Store Banner",
                              style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFF0a0f32),
                              borderRadius: BorderRadius.all(const Radius.circular(20)),
                              image: new DecorationImage(
                                image: borderimg,
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    chooseImage();
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 10),
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF101a6f),
                                        borderRadius: BorderRadius.all(const Radius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                        child: Text(
                                          "Choose File",
                                          style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                        ),
                                      )),
                                ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    uploadimageString,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Color(0xFF3aa2a2a2)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Image(image: NetworkImage(map["store_banner"]), height: 80, width: 80, fit: BoxFit.scaleDown),
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
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(left: 30, top: 10),
                                                    child: Text(
                                                      "Select shipping address location",
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
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            alignment: Alignment.center,
                                                            margin: EdgeInsets.only(top: 10, bottom: 10),
                                                            decoration: BoxDecoration(border: Border.all(color: Colors.blue), color: Colors.black),
                                                            child: InkWell(
                                                              onTap: () {},
                                                              child: Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Text(
                                                                  "Choose Image",
                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: InkWell(
                                onTap: () {
                                  getStringValuesSF().then((value) => uploadImage(uploadimage.path, value, context));
                                },
                                child: Container(
                                  height: 60,
                                  margin: EdgeInsets.only(right: 20, top: 10),
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage("assets/images/upload.png"),
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Change Your Store Link",
                              style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFF0a0f32),
                              borderRadius: BorderRadius.all(const Radius.circular(20)),
                              image: new DecorationImage(
                                image: borderimg,
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "https://proesportsgaming.com/store/",
                                    style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Color(0xFF7052d0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Homescreen(),
                              ));
                            },
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.only(right: 20, top: 10),
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Image(
                                  image: AssetImage("assets/images/go_to_store.png"),
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Default Link : " + map["store_link"],
                              style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFF0a0f32),
                              borderRadius: BorderRadius.all(const Radius.circular(20)),
                              image: new DecorationImage(
                                image: borderimg,
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: TextField(
                                    style: style,
                                    controller: username_controller,
                                    decoration: InputDecoration(
                                      hintText: "Default Link",
                                      border: InputBorder.none,
                                      hintStyle: hintstyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.cyan,
                                        strokeWidth: 5,
                                      ),
                                    );
                                  });

                              getStringValuesSF().then((userids) => api.updatestorelink(userids, username_controller.text, context).then((value) => getSWData(userids)));
                            },
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.only(right: 20, top: 10),
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Image(
                                  image: AssetImage("assets/images/submit.png"),
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
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

/// Example of using a custom primary measure and domain axis replacing the
/// renderSpec with one with a custom font size and a custom color.
///
/// There are many axis styling options in the SmallTickRenderer allowing you
/// to customize the font, tick lengths, and offsets.
class CustomFontSizeAndColor extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomFontSizeAndColor(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,

      /// Assign a custom style for the domain axis.
      ///
      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(color: charts.MaterialPalette.white))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(color: charts.MaterialPalette.white))),
    );
  }

  /// Create series list with single series

}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

List<charts.Series<OrdinalSales, String>> _createSampleData() {
  return [
    new charts.Series<OrdinalSales, String>(
      id: 'Global Revenue',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: list,
    ),
  ];
}

Widget levellist(List<dynamic> snaplevellist) {
  Color color3 = Color(0xFF6ae7e0);

  if (snaplevellist == null) {
    return Container(
      color: Color(0xFF0a0f32),
      child: Center(
        child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: color3),
      ),
    );
  }

  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Level Number",
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      snaplevellist[index]["level"],
                      style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Level name",
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    snaplevellist[index]["level_title"],
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Level Reward",
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    new String.fromCharCodes(new Runes('\u0024')) + snaplevellist[index]["reward"],
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Item Sold",
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    snaplevellist[index]["item_sold"],
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Status",
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    snaplevellist[index]["status"],
                    style: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
    itemCount: snaplevellist.length,
  );
}
