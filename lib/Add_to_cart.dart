import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peg/Checkout.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:peg/main.dart';

class Addtocart extends StatelessWidget {
  String id;

  Addtocart({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: AddtoCARTfull(
          id: id,
        ),
      ),
    ));
  }
}

class AddtoCARTfull extends StatefulWidget {
  String id;

  AddtoCARTfull({Key key, @required this.id}) : super(key: key);

  @override
  _AddtoCARTfullState createState() => _AddtoCARTfullState(id);
}

class _AddtoCARTfullState extends State<AddtoCARTfull> {
  String id;
  RestDatasource api = new RestDatasource();

  _AddtoCARTfullState(this.id);

  int qty = 0;
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);

  String userid;

  var ref_seller_id;

  var Custom_Tag;

  var product_image;

  var product_id;

  var price;

  var product_fee;

  var int_fee;

  var product_name;

  String selvertion;
  String extraamount;

  Map<String, String> apimap = new Map();

  List<double> totallist = List();
  List<Map<String, dynamic>> snapshotitemlist = List();
  List<dynamic> atrlbl = List();
  List<dynamic> optlbl = List();

  Future<String> getSWData(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_cart_products + id), headers: {"Accept": "application/json"});

    setState(() {
      getStringValuesSF().then((value) => {
            userid = value,
          });
    });

    if (json.decode(res.body)["status_code"] == 400) {
      if (json.decode(res.body)["message"] == "Your Cartlist is Empty") {
        setState(() {
          snapshotitemlist.clear();
        });
      }

      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      throw new Exception(json.decode(res.body));
    } else {
      try {
        setState(() {
          snapshotitemlist.clear();
          snapshotitemlist = List<Map<String, dynamic>>.from(json.decode(res.body)['cart_list']);
        });
      } on Exception catch (_) {}
    }
    return "Success";
  }

  Widget gettotal() {
    double sumtotal = 0.0;

    for (int i = 0; i < snapshotitemlist.length; i++) {
      double total;
      total = (double.parse(snapshotitemlist[i]["amount"].toString()) + double.parse(snapshotitemlist[i]["product_fee"].toString())) * double.parse(snapshotitemlist[i]["qty"].toString());

      sumtotal = sumtotal + total;
    }

    return Container(
      child: Text(
        new String.fromCharCodes(new Runes('\u0024')) + sumtotal.toStringAsFixed(2),
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData(this.id);
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
                child: Center(
                    child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Homescreen()), (Route<dynamic> route) => false);
                            },
                            child: Align(
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
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Cart",
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
                    SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          atrlbl = snapshotitemlist[index]["sel_variation"]["atrlbl"];
                          optlbl = snapshotitemlist[index]["sel_variation"]["optlbl"];

                          print(atrlbl);
                          print(optlbl);
                          return Container(
                            margin: EdgeInsets.only(right: 30, left: 30, bottom: 10),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Image(
                                              image: AssetImage("assets/images/rounded_rectangle_4.png"),
                                              fit: BoxFit.fill,
                                              height: 335,
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
                                                                      "Do you want to delete cart product ?",
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
                                                                  api.deletecart(userid, snapshotitemlist[index]["id"].toString()).then((value) => {Navigator.pop(context), onChange()});
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
                                                  margin: EdgeInsets.only(right: 10, left: 30, top: 20),
                                                  child: Image(image: AssetImage("assets/images/icons_8_delete_bin_24.png"), height: 25, width: 20, fit: BoxFit.fill),
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
                                                            snapshotitemlist[index]["product_name"].toString(),
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
                                                          margin: EdgeInsets.only(left: 30, top: 20),
                                                          child: Image(image: NetworkImage(snapshotitemlist[index]["product_image"]), height: 80, width: 80, fit: BoxFit.scaleDown),
                                                        ),
                                                        Align(
                                                          alignment: Alignment.center,
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 30, top: 20),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    print("chechuserid" + userid.toString());

                                                                    int qtyys = int.parse(snapshotitemlist[index]["qty"]);
                                                                    qtyys = qtyys - 1;

                                                                    apimap["user_id"] = userid;
                                                                    apimap["product_id"] = snapshotitemlist[index]["product_id"].toString();
                                                                    apimap["cart_item_id"] = snapshotitemlist[index]["id"].toString();
                                                                    apimap["prdct_qty"] = qtyys.toString();
                                                                    apimap["extra_amount"] = "0";

                                                                    api.cart_product_qty_updatess(apimap).then((value) => {onChange()});
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
                                                                    snapshotitemlist[index]["qty"].toString(),
                                                                    style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 16.0, color: Colors.white),
                                                                  ),
                                                                  decoration: BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(2.0)),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    print("chechuserid" + userid.toString());

                                                                    int qtyys = int.parse(snapshotitemlist[index]["qty"]);
                                                                    qtyys = qtyys + 1;

                                                                    apimap["user_id"] = userid;
                                                                    apimap["product_id"] = snapshotitemlist[index]["product_id"].toString();
                                                                    apimap["cart_item_id"] = snapshotitemlist[index]["id"].toString();
                                                                    apimap["prdct_qty"] = qtyys.toString();
                                                                    apimap["extra_amount"] = "0";
                                                                    api.cart_product_qty_updatess(apimap).then((value) => {onChange()});
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
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 30, top: 20),
                                                          child: Text(
                                                            "Price :",
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
                                                            "Total :",
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
                                                            margin: EdgeInsets.only(right: 10, top: 20, bottom: 50),
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
                                                            )),
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10, top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(new Runes('\u0024')) + snapshotitemlist[index]["amount"].toString(),
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10, top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(new Runes('\u0024')) + snapshotitemlist[index]["product_fee"].toString(),
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Colors.white),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10, top: 10),
                                                          child: Text(
                                                            new String.fromCharCodes(new Runes('\u0024')) + totalamunt(double.parse(snapshotitemlist[index]["amount"]), double.parse(snapshotitemlist[index]["product_fee"]), double.parse(snapshotitemlist[index]["qty"])),
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
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          );
                        },
                        itemCount: snapshotitemlist.length,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
                        child: Column(
                          children: [
                            CustomPaint(
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
                                  height: 100,
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              "CART TOTAL",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
                                            ),
                                          ),
                                          gettotal()
                                        ],
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
                                                              margin: EdgeInsets.only(left: 30, top: 20),
                                                              child: Text(
                                                                "Select shipping address location",
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
                                                            child: Padding(
                                                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                      alignment: Alignment.center,
                                                                      margin: EdgeInsets.only(top: 10),
                                                                      decoration: BoxDecoration(color: Color(0xFFff5000)),
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          Navigator.of(context).pushAndRemoveUntil(
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => Checkout(
                                                                                        checkinsideoutside: "inside",
                                                                                      )),
                                                                              (Route<dynamic> route) => false);
                                                                        },
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Text(
                                                                            "INSIDE UNITED STATES",
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                  Container(
                                                                      alignment: Alignment.center,
                                                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                                                      decoration: BoxDecoration(border: Border.all(color: Colors.blue), color: Colors.black),
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          Navigator.of(context).pushAndRemoveUntil(
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => Checkout(
                                                                                        checkinsideoutside: "outside",
                                                                                      )),
                                                                              (Route<dynamic> route) => false);
                                                                        },
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Text(
                                                                            "OUTSIDE UNITED STATES",
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
                                        child: Container(
                                          height: 30,
                                          margin: EdgeInsets.only(top: 20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(color: Color(0xFFff5000)),
                                          child: Text(
                                            "Proceed to Checkout",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        child: new Image(
                                          image: AssetImage('assets/images/group_2_copy_25689.png'),
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Homescreen()), (Route<dynamic> route) => false);
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "Clear Cart",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 15.0, color: Color(0xFFff5000)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                )),
              )
            ],
          ),
          onWillPop: () async {
            return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Homescreen()), (Route<dynamic> route) => false);
          }),
    );
  }

  String totalamunt(double amount, double profee, double qty) {
    double total;
    total = (amount + profee) * qty;
    totallist.add(total);

    return total.toStringAsFixed(2);
  }

  onChange() {
    setState(() {
      getSWData(userid);
    });
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

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 10), child: Text("Loading")),
      ],
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
