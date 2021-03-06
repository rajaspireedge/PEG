import 'package:flutter/material.dart';
import 'package:peg/MyOrder.dart';
import 'package:peg/PaypalPayment.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/main.dart';
import 'package:peg/makePayment.dart';

class Payment extends StatelessWidget {
  Map<String, dynamic> map = new Map();

  Payment(this.map);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: PaymentFull(map)),
      ),
    );
  }
}

class PaymentFull extends StatefulWidget {
  Map<String, dynamic> map = new Map();

  PaymentFull(this.map);

  @override
  _PaymentFullState createState() => _PaymentFullState(map);
}

var back_1 = new AssetImage('assets/images/back_1.png');
var borderimg2 = new AssetImage('assets/images/rounded_rectangle_234.png');
var borderimg = new AssetImage('assets/images/borderimg.png');

Color color1 = Color(0xFF06cdff);
Color color2 = Colors.white;
Color color3 = Color(0xFF6ae7e0);

class _PaymentFullState extends State<PaymentFull> {
  Map<String, dynamic> map = new Map();

  _PaymentFullState(this.map);


  String userid;

  @override
  Widget build(BuildContext context) {
    print("zdklmkmxc" + map.toString());

    getStringValuesSF().then((value) => userid = value);

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
                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 18.0, color: Color(0xFFff5000)),
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 18.0, color: Color(0xFFff5000)),
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
                    Container(
                      margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Payment Information",
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 18.0, color: Color(0xFFff5000)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20.0),
                            child: Image(
                              image: AssetImage('assets/images/bill.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
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
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Shipping Charge",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          new String.fromCharCodes(new Runes('\u0024')) + map["shipping_charge"].toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Total variation amount",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          new String.fromCharCodes(new Runes('\u0024')) + map["total_variation_amount"].toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Total",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          new String.fromCharCodes(new Runes('\u0024')) + map["subscribe_amount"].toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /* Container(
                                      alignment: Alignment.centerRight,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/rectangle_4_copy_2345.png'),
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),*/
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Pay with Paypal",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                          child: Image(
                                        image: AssetImage("assets/images/paypal_buttons_peg.png"),
                                        width: 80,
                                        height: 20,
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0, -50, 0),
                      child: new InkWell(
                        onTap: () {
                          // make PayPal payment
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PaypalPayment(
                                map,
                                onFinish: (number) async {
                                  // payment done44

                                },
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: new Image(
                                image: AssetImage('assets/images/group_2_copy_2966.png'),
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
          // ignore: missing_return
          onWillPop: () async {
            Navigator.pop(context);
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
