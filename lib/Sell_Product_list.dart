import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/Add_Product.dart';
import 'package:peg/homescreen.dart';

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

class _SellProductPAGEState extends State<SellProductPAGE> {
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);

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
                                      "Sell Products",
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
                              "My Selling Products",
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
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: (context) =>
                                                  AddproductFull(),
                                            ));
                                          },
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/invalid_name.png"),
                                            height: 80,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Text(
                                            "Add product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Bold',
                                                letterSpacing: 0.03,
                                                fontSize: 12.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 50, top: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/local_tax.png"),
                                                  height: 50,
                                                  width: 140,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                              Container(
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/international_tax.png"),
                                                  height: 50,
                                                  width: 140,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                                height: 120,
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                        margin:
                                            EdgeInsets.only(right: 5, top: 5),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/edit_2.png"),
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: 5, top: 5),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/icons_8_delete_bin_24.png"),
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "T-Shirt",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto-Bold',
                                          letterSpacing: 0.03,
                                          fontSize: 16.0,
                                          color: Color(0xFF0a0f32)),
                                    ),
                                  ),
                                  Card(
                                    elevation: 5.0,
                                    margin: EdgeInsets.only(
                                        top: 5.0,
                                        right: 5.0,
                                        left: 5.0,
                                        bottom: 5.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Qty-1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto-Bold',
                                                letterSpacing: 0.03,
                                                fontSize: 10.0,
                                                color: Color(0xFF0a0f32)),
                                          ),
                                        ),
                                        Align(
                                          child: Container(
                                            height: 70,
                                            margin:
                                                EdgeInsets.only(bottom: 5.0),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/img.png"))),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    "Amount :",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Roboto-Bold',
                                                        letterSpacing: 0.03,
                                                        fontSize: 10.0,
                                                        color:
                                                            Color(0xFF0a0f32)),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "200",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Roboto-Bold',
                                                        letterSpacing: 0.03,
                                                        fontSize: 10.0,
                                                        color:
                                                            Color(0xFF8616d3)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Fee :",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Roboto-Bold',
                                                        letterSpacing: 0.03,
                                                        fontSize: 10.0,
                                                        color:
                                                            Color(0xFF0a0f32)),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 5.0),
                                                  child: Text(
                                                    "200",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Roboto-Bold',
                                                        letterSpacing: 0.03,
                                                        fontSize: 10.0,
                                                        color:
                                                            Color(0xFF8616d3)),
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            itemCount: 4,
                          ),
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
