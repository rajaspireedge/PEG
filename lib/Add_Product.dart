import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AddproductFull(),
        ),
      ),
    );
  }
}

class AddproductFull extends StatefulWidget {
  @override
  _AddproductFullState createState() => _AddproductFullState();
}

class _AddproductFullState extends State<AddproductFull> {
  final username_controller = TextEditingController();
  final username_controller2 = TextEditingController();
  final username_controller3 = TextEditingController();
  final username_controller4 = TextEditingController();
  Map<String, String> apimap = new Map();

  TextStyle hintstyle = TextStyle(fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white);
  var back_1 = new AssetImage('assets/images/back_1.png');

  String _mySelection;
  String _mySelection2;

  List<Map<String, dynamic>> snapshotproductlist = List();
  List<Map<String, dynamic>> snapshotplayerlist = List();

  List data = List(); //edited line
  List data2 = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_categories), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody["category_list"];
    });

    return "Success";
  }

  Future<String> getProductList() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_products), headers: {"Accept": "application/json", "content-type": "application/json"});
    var resBody = json.decode(res.body);
    print(res.body);

    setState(() {
      snapshotproductlist = resBody["product_list"];
    });

    return "Success";
  }

  Future<String> getsubData(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_subcategories + id), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data2 = resBody["subcategory_list"];
    });

    return "Sucess";
  }

  Widget _BasicLayout() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Product Basic Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 20.0, color: Colors.white),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                    decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              style: style,
                              controller: username_controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                hintText: "Product Title",
                                border: InputBorder.none,
                                hintStyle: hintstyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Stack(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                        decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 30.0, left: 20),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: Color(0xFF0a0f32),
                                    iconSize: 0.0,
                                    hint: Text(
                                      "Please select main category",
                                      style: style,
                                    ),
                                    isExpanded: true,
                                    style: style,
                                    value: _mySelection,
                                    onChanged: (newVal) {
                                      setState(() {
                                        _mySelection = newVal;
                                        _mySelection2 = null;
                                        getsubData(_mySelection);
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
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 30.0),
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
                Stack(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                        decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 30.0, left: 20),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: Color(0xFF0a0f32),
                                    iconSize: 0.0,
                                    hint: Text(
                                      "Please select sub category",
                                      style: style,
                                    ),
                                    isExpanded: true,
                                    style: style,
                                    value: _mySelection2,
                                    onChanged: (newVal) {
                                      setState(() {
                                        _mySelection2 = newVal;
                                      });
                                    },
                                    items: data2.map((item) {
                                      return DropdownMenuItem(
                                        child: new Text(
                                          item['name'],
                                          style: style,
                                        ),
                                        value: item['id'],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 30.0),
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
                    height: 200,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                    decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFF00a99d))),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 30.0),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              style: style,
                              controller: username_controller4,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18),
                                hintText: "Description",
                                border: InputBorder.none,
                                hintStyle: hintstyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF00a99d)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  transform: Matrix4.translationValues(-25, 0, 0),
                  child: Image(
                    image: AssetImage("assets/images/group_2_copy_234.png"),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 80,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  apimap["product_name"] = username_controller.text.toString();
                  apimap["category_id"] = _mySelection.toString();
                  apimap["subcategory_id"] = _mySelection2.toString();
                  apimap["description"] = username_controller4.text.toString();
                  print(apimap);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    transform: Matrix4.translationValues(25, 0, 0),
                    child: Image(
                      image: AssetImage("assets/images/group_2_copy_2_234.png"),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 80,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _PriceLayout() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Product Price Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 20.0, color: Colors.white),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                    decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 30.0),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              style: style,
                              controller: username_controller2,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18),
                                hintText: "Please Enter Price",
                                border: InputBorder.none,
                                hintStyle: hintstyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                    decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 30.0),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              style: style,
                              controller: username_controller3,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18),
                                hintText: "Please Enter Qty",
                                border: InputBorder.none,
                                hintStyle: hintstyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF00a99d)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  transform: Matrix4.translationValues(-25, 0, 0),
                  child: Image(
                    image: AssetImage("assets/images/group_2_copy_234.png"),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 80,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  transform: Matrix4.translationValues(25, 0, 0),
                  child: Image(
                    image: AssetImage("assets/images/group_2_copy_2_234.png"),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 80,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _ProductLayout() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Product Images Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 20.0, color: Colors.white),
            ),
          ),
          Container(
            child: Column(
              children: [
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
                  margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
                  decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                  child: Row(
                    children: [
                      Container(
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
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "No file chosen",
                          style: TextStyle(fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 10.0, color: Color(0xFF3aa2a2a2)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF00a99d)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  transform: Matrix4.translationValues(-25, 0, 0),
                  child: Image(
                    image: AssetImage("assets/images/group_2_copy_234.png"),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 80,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  transform: Matrix4.translationValues(25, 0, 0),
                  child: Image(
                    image: AssetImage("assets/images/group_2_copy_2_234.png"),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 80,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSWData();
    this.getProductList();
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
                                      "Add Products",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 16.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10.0),
                            color: Color(0xFF0a0f32),
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Image(
                                        image: AssetImage("assets/images/rectangle_11.png"),
                                        height: 34,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 150,
                                      height: 34,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Color(0xFFff5000))),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 150,
                                      height: 34,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Color(0xFFff5000))),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 150,
                                      height: 34,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Color(0xFFff5000))),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          _BasicLayout()
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
