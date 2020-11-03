import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peg/Checkout.dart';
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
final username_controller22 = TextEditingController();

final edit_controller = TextEditingController();
final edit_controller22 = TextEditingController();

TextStyle hintstyle = TextStyle(fontFamily: 'Roboto-Bold', fontSize: 10.0, color: Colors.white);

class _CategoryFullState extends State<CategoryFull> {
  Color color1 = Color(0xFF06cdff);
  Color color2 = Colors.white;
  Color color3 = Color(0xFF6ae7e0);
  String challengemail;

  bool officon3;
  bool onicon3;

  var back_1 = new AssetImage('assets/images/back_1.png');
  var borderimg = new AssetImage('assets/images/rounded_rectangle_234.png');
  String _mySelection;

  List data = List(); //edited line
  List data2 = List();

  bool checkstatus;

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
                        style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
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
                                                    "Please category",
                                                    style: style,
                                                  ),
                                                  style: style,
                                                  value: _mySelection,
                                                  onChanged: (newVal) {
                                                    setState(() {
                                                      _mySelection = newVal;
                                                    });
                                                  },
                                                  items: data.map((item) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                        item['name'],
                                                        style: style,
                                                      ),
                                                      value: item['id'],
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
                                  child: entercategoryname22,
                                )),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (username_controller22.text.length == 0) {
                          Fluttertoast.showToast(msg: "Enter Category", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                        } else {
                          getStringValuesSF().then((userid) => api.add_category22(userid, _mySelection, username_controller22.text, context).then((value) => {getSWData(userid)}));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image(
                          image: AssetImage("assets/images/submit.png"),
                          height: 40,
                          width: 120,
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

  Future<String> getSWData(String userid) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_categories + "/" + userid), headers: {"Accept": "application/json", "content-type": "application/json"});
    var resBody = json.decode(res.body);

    if (json.decode(res.body)["status_code"] == 400) {
      if (json.decode(res.body)["message"] == "Category Not Available") {
        setState(() {
          data.clear();
        });
      }

      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      throw new Exception(json.decode(res.body));
    } else {
      setState(() {
        data.clear();
        data = resBody["category_list"];
        data2.clear();
        for (int i = 0; i < data.length; i++) {
          List list = data[i]["subcategories"];

          if (list.isNotEmpty) {
            data2 = data[i]["subcategories"];
          }
        }
      });
    }

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

  final editcategoryname = TextField(
    style: style,
    controller: edit_controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(18),
      hintText: "Enter Category Name",
      border: InputBorder.none,
      hintStyle: hintstyle,
    ),
  );

  final editcategoryname22 = TextField(
    style: style,
    controller: edit_controller22,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(18),
      hintText: "Enter Category Name",
      border: InputBorder.none,
      hintStyle: hintstyle,
    ),
  );

  final entercategoryname22 = TextField(
    style: style,
    controller: username_controller22,
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
    getStringValuesSF().then((value) => {getSWData(value)});
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
                                      "Category",
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
                              "My Category",
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
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
                                                                    child: entercategoryname,
                                                                  )),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (username_controller.text.length == 0) {
                                                                  Fluttertoast.showToast(msg: "Enter Category", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                                                                } else {
                                                                  getStringValuesSF().then((userid) => api.add_category(userid, username_controller.text, context).then((value) => getSWData(userid)));
                                                                }
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.only(bottom: 12, top: 20),
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
                                              child: Image(
                                                image: AssetImage("assets/images/add_category.png"),
                                                height: 50,
                                                width: 120,
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
                                                image: AssetImage("assets/images/add_sub_category.png"),
                                                height: 50,
                                                width: 120,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          )
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                "Sl.no.",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Category",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Sub Category",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Status",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 20),
                                              child: Text(
                                                "Action",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                          itemBuilder: (context, index) {
                                            if (data[index]["status"] == "1") {
                                              checkstatus = true;
                                            } else if (data[index]["status"] == "0") {
                                              checkstatus = false;
                                            }

                                            if (checkstatus) {
                                              onicon3 = false;
                                              officon3 = true;
                                            } else {
                                              onicon3 = true;
                                              officon3 = false;
                                            }
                                            return Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                                  child: Image(
                                                    image: AssetImage("assets/images/ellipse_4222.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      child: Text(
                                                        (index + 1).toString() + ".",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 15),
                                                      child: Text(
                                                        "Main Category",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 20,
                                                      margin: EdgeInsets.only(top: 15),
                                                      child: ScrollingText(
                                                        ratioOfBlankToScreen: 0.05,
                                                        text: data[index]["name"],
                                                        textStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.black),
                                                      ),
                                                    ),
                                                    GestureDetector(
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

                                                        if (data[index]["status"] == "1") {
                                                          checkstatus = true;
                                                        } else if (data[index]["status"] == "0") {
                                                          checkstatus = false;
                                                        }

                                                        if (checkstatus) {
                                                          challengemail = "0";
                                                          setState(() {
                                                            getStringValuesSF().then((userid) => api.category_status_updatess(data[index]["id"], challengemail, context).then((value) => getSWData(userid)));
                                                          });
                                                        } else {
                                                          challengemail = "1";
                                                          setState(() {
                                                            getStringValuesSF().then((userid) => api.category_status_updatess(data[index]["id"], challengemail, context).then((value) => getSWData(userid)));
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        width: 50,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              child: new Image(
                                                                image: AssetImage("assets/images/rounded_rectangle_2_copy.png"),
                                                                height: 50,
                                                                width: 65,
                                                              ),
                                                            ),
                                                            Visibility(
                                                                visible: officon3,
                                                                child: Container(
                                                                    margin: EdgeInsets.all(2),
                                                                    child: Row(
                                                                      children: [
                                                                        Image(
                                                                          image: AssetImage("assets/images/ellipse_5_copy.png"),
                                                                          height: 50,
                                                                          width: 20,
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(left: 10),
                                                                          child: Text(
                                                                            "on",
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 7.0, color: Colors.black),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))),
                                                            Visibility(
                                                                visible: onicon3,
                                                                child: Container(
                                                                    margin: EdgeInsets.all(2),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: EdgeInsets.only(left: 4),
                                                                          child: Text(
                                                                            "off",
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 7.0, color: Colors.black),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(left: 9),
                                                                          child: Image(
                                                                            image: AssetImage("assets/images/ellipse_5_copy.png"),
                                                                            height: 50,
                                                                            width: 20,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))),
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.only(left: 8, top: 20),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
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
                                                                                  child: editcategoryname,
                                                                                )),
                                                                          ),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              if (edit_controller.text.length == 0) {
                                                                                Fluttertoast.showToast(msg: "Enter Category", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                                                                              } else {
                                                                                getStringValuesSF().then((userid) => api.edit_cat(data[index]["id"], edit_controller.text, context).then((value) => getSWData(userid)));
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              margin: EdgeInsets.only(bottom: 12, top: 20),
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
                                                            margin: EdgeInsets.only(right: 5, top: 23),
                                                            child: Image(
                                                              image: AssetImage("assets/images/edit_2222.png"),
                                                              width: 13,
                                                              height: 13,
                                                              fit: BoxFit.cover,
                                                            ),
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
                                                                                  "Do you want to delete Category ?",
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
                                                                              api.deletecat(data[index]["id"].toString()).then((value) => {Navigator.pop(context), getStringValuesSF().then((value) => getSWData(value))});
                                                                            },
                                                                            child: Container(
                                                                              margin: EdgeInsets.only(bottom: 12),
                                                                              child: Image(
                                                                                image: AssetImage("assets/images/submit.png"),
                                                                                height: 60,
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
                                                            margin: EdgeInsets.only(right: 5, top: 23),
                                                            child: Image(
                                                              image: AssetImage("assets/images/icons_8_delete_bin_24.png"),
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
                                            );
                                          },
                                          itemCount: data.length,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                          itemBuilder: (context, index) {
                                            if (data2[index]["status"] == "1") {
                                              checkstatus = true;
                                            } else if (data2[index]["status"] == "0") {
                                              checkstatus = false;
                                            }

                                            if (checkstatus) {
                                              onicon3 = false;
                                              officon3 = true;
                                            } else {
                                              onicon3 = true;
                                              officon3 = false;
                                            }

                                            return Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                                  child: Image(
                                                    image: AssetImage("assets/images/ellipse_4222.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      child: Text(
                                                        (index + 1).toString() + ".",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 15),
                                                      child: Text(
                                                        "Sub Category",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 20,
                                                      margin: EdgeInsets.only(top: 15),
                                                      child: ScrollingText(
                                                        ratioOfBlankToScreen: 0.05,
                                                        text: data2[index]["name"],
                                                        textStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Colors.black),
                                                      ),
                                                    ),
                                                    GestureDetector(
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

                                                        if (data2[index]["status"] == "1") {
                                                          checkstatus = true;
                                                        } else if (data[index]["status"] == "0") {
                                                          checkstatus = false;
                                                        }

                                                        if (checkstatus) {
                                                          challengemail = "0";
                                                          setState(() {
                                                            getStringValuesSF().then((userid) => api.category_status_updatess(data2[index]["id"], challengemail, context).then((value) => getSWData(userid)));
                                                          });
                                                        } else {
                                                          challengemail = "1";
                                                          setState(() {
                                                            getStringValuesSF().then((userid) => api.category_status_updatess(data2[index]["id"], challengemail, context).then((value) => getSWData(userid)));
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        width: 50,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              child: new Image(
                                                                image: AssetImage("assets/images/rounded_rectangle_2_copy.png"),
                                                                height: 50,
                                                                width: 65,
                                                              ),
                                                            ),
                                                            Visibility(
                                                                visible: officon3,
                                                                child: Container(
                                                                    margin: EdgeInsets.all(2),
                                                                    child: Row(
                                                                      children: [
                                                                        Image(
                                                                          image: AssetImage("assets/images/ellipse_5_copy.png"),
                                                                          height: 50,
                                                                          width: 20,
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(left: 10),
                                                                          child: Text(
                                                                            "on",
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 7.0, color: Colors.black),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))),
                                                            Visibility(
                                                                visible: onicon3,
                                                                child: Container(
                                                                    margin: EdgeInsets.all(2),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: EdgeInsets.only(left: 4),
                                                                          child: Text(
                                                                            "off",
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 7.0, color: Colors.black),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(left: 9),
                                                                          child: Image(
                                                                            image: AssetImage("assets/images/ellipse_5_copy.png"),
                                                                            height: 50,
                                                                            width: 20,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))),
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.only(left: 8, top: 20),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
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
                                                                              GestureDetector(
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
                                                                                  child: editcategoryname22,
                                                                                )),
                                                                          ),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              if (edit_controller22.text.length == 0) {
                                                                                Fluttertoast.showToast(msg: "Enter Category", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 12, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                                                                              } else {
                                                                                getStringValuesSF().then((userid) => api.edit_cat22(data2[index]["id"], data2[index]["parent_id"], edit_controller22.text, context).then((value) => getSWData(userid)));
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              margin: EdgeInsets.only(bottom: 12, top: 20),
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
                                                            margin: EdgeInsets.only(right: 5, top: 23),
                                                            child: Image(
                                                              image: AssetImage("assets/images/edit_2222.png"),
                                                              width: 13,
                                                              height: 13,
                                                              fit: BoxFit.cover,
                                                            ),
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
                                                                                  "Do you want to delete Category ?",
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
                                                                              api.deletecat(data2[index]["id"].toString()).then((value) => {Navigator.pop(context), getStringValuesSF().then((value) => getSWData(value))});
                                                                            },
                                                                            child: Container(
                                                                              margin: EdgeInsets.only(bottom: 12),
                                                                              child: Image(
                                                                                image: AssetImage("assets/images/submit.png"),
                                                                                height: 60,
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
                                                            margin: EdgeInsets.only(right: 5, top: 23),
                                                            child: Image(
                                                              image: AssetImage("assets/images/icons_8_delete_bin_24.png"),
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
                                            );
                                          },
                                          itemCount: data2.length,
                                        ),
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
