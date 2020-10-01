import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/homescreen.dart';

class MyStoreLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: MyStore(),),
      ),
    );
  }
}

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);

  var borderimg = new AssetImage('assets/images/borderimg.png');

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
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/back_12.png'),
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "My Store",
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
                        margin: EdgeInsets.only(left: 30),
                        child: Text(
                          "Store Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto-Bold',
                              letterSpacing: 0.03,
                              fontSize: 16.0,
                              color: Colors.white),
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
                                          margin: EdgeInsets.only(
                                              right: 10, top: 5),
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Medium',
                                                letterSpacing: 0.03,
                                                fontSize: 12.0,
                                                color: Color(0xFFff5000)),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/save_money_white.png"))),
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
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Medium',
                                          letterSpacing: 0.03,
                                          fontSize: 12.0,
                                          color: Color(0xFFff5000)),
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
                                          margin: EdgeInsets.only(
                                              right: 10, top: 5),
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Medium',
                                                letterSpacing: 0.03,
                                                fontSize: 12.0,
                                                color: Color(0xFFff5000)),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/shopping_bag_white.png"))),
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
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Medium',
                                          letterSpacing: 0.03,
                                          fontSize: 12.0,
                                          color: Color(0xFFff5000)),
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 30),
                              child: Column(
                                children: [
                                  CustomPaint(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 10, top: 5),
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Medium',
                                                letterSpacing: 0.03,
                                                fontSize: 12.0,
                                                color: Color(0xFFff5000)),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/sold_items_white.png"))),
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
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Medium',
                                          letterSpacing: 0.03,
                                          fontSize: 12.0,
                                          color: Color(0xFFff5000)),
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
                                  "1",
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
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Current Level",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto-Medium',
                                            letterSpacing: 0.03,
                                            fontSize: 16.0,
                                            color: Color(0xFF4edbfb)),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Level : New Level One",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto-Medium',
                                            letterSpacing: 0.03,
                                            fontSize: 12.0,
                                            color: Color(0xFFff5000)),
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
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto-Medium',
                                      letterSpacing: 0.03,
                                      fontSize: 16.0,
                                      color: Color(0xFFff5000)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/group_9.png"))),
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
                                style: TextStyle(
                                    fontFamily: 'Roboto-Bold',
                                    letterSpacing: 0.03,
                                    fontSize: 18.0,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
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
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            margin:
                                EdgeInsets.only(right: 30, left: 30, top: 20),
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Store Banner",
                              style: TextStyle(
                                  fontFamily: 'Roboto-Bold',
                                  letterSpacing: 0.03,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFF0a0f32),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(20)),
                              image: new DecorationImage(
                                image: borderimg,
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 10),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF101a6f),
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 5.0, 10.0, 5.0),
                                      child: Text(
                                        "Choose File",
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Bold',
                                            letterSpacing: 0.03,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "No file choosen",
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Bold',
                                        letterSpacing: 0.03,
                                        fontSize: 10.0,
                                        color: Color(0xFF3aa2a2a2)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
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
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            margin:
                                EdgeInsets.only(right: 30, left: 30, top: 20),
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Change Your Store Link",
                              style: TextStyle(
                                  fontFamily: 'Roboto-Bold',
                                  letterSpacing: 0.03,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFF0a0f32),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(20)),
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
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Bold',
                                        letterSpacing: 0.03,
                                        fontSize: 10.0,
                                        color: Color(0xFF7052d0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.only(right: 20, top: 10),
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Image(
                                image:
                                    AssetImage("assets/images/go_to_store.png"),
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 0.5,
                            margin:
                                EdgeInsets.only(right: 30, left: 30, top: 20),
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Default Link : 1736",
                              style: TextStyle(
                                  fontFamily: 'Roboto-Bold',
                                  letterSpacing: 0.03,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFF0a0f32),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(20)),
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
                                    "1376",
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Bold',
                                        letterSpacing: 0.03,
                                        fontSize: 10.0,
                                        color: Color(0xFF7052d0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
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
                        ],
                      )
                    ],
                  ),
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
