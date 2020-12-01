import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peg/RestDatasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:peg/homescreen.dart';
import 'package:peg/My_Store.dart';

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

  String screenchange = "1";
  String boxchange = "1";

  List<Map<String, dynamic>> snapshotproductlist = List();
  List<Map<String, dynamic>> snapshotplayerlist = List();
  List<dynamic> attributelist = List();
  List<Map<int, bool>> dynamicbools = List();

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

  void onChanged(bool value, int index, int arrayindex, List<dynamic> list, String attribute_id, String imageupload) {
    setState(() {
      if (value == true) {
        value = false;
      } else {
        value = true;
      }

      dynamicbools[arrayindex][index] = value;

      String attr_id;
      String attr_image;

      apimap.forEach((key, value) {
        if (key.contains("[") && key.contains("attr_id")) {
          const start = "[";
          const end = "]";
          final startIndex = key.lastIndexOf(start);
          final endIndex = key.indexOf(end, startIndex + start.length);

          if (key.substring(startIndex + start.length, endIndex) == attribute_id) {
            attr_id = key;
          }
        }
      });

      String optionid = list[index]["opt_order"];

      attr_id = "attr_id" + "[" + attribute_id + "]" + "[" + optionid + "]";

      apimap[attr_id] = list[index]["option_label"];
    });
  }

  File uploadimage; //variable for choosed file
  String userid;

  Future<void> chooseImage(String optionid, String attribute_id) async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    String attr_image;

    setState(() {
      uploadimage = choosedimage;
      attr_image = "attr_image" + "[" + attribute_id + "]" + "[" + optionid + "]";
      apimap[attr_image] = uploadimage.path;
      print(apimap);
    });
  }

  Future<void> chooseImage22() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      if (choosedimage.path == "") {
        productimage = "No file chosen";
      } else {
        String productimagekey = "product_image[]";
        apimap[productimagekey] = choosedimage.path;
        productimage = choosedimage.path;
      }
    });
  }

  Future<String> getAttribute() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_attributes), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      attributelist = resBody["attr_list"];

      for (int i = 0; i < attributelist.length; i++) {
        List<dynamic> tempsnap = attributelist[i]["option_list"];
        Map<int, bool> boolvalues = Map();
        for (int j = 0; j < tempsnap.length; j++) {
          boolvalues[j] = false;
        }
        dynamicbools.add(boolvalues);
      }
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

    return "Success";
  }

  Widget _BasicLayout() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
          Container(
            margin: EdgeInsets.only(top: 20),
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
                  if (username_controller.text.toString().trim().length == 0) {
                    Fluttertoast.showToast(msg: "Select Product Name", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                  } else if (_mySelection.toString().trim().length == 0) {
                    Fluttertoast.showToast(msg: "Select Main Category", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                  } else if (_mySelection2.toString().trim().length == 0) {
                    Fluttertoast.showToast(msg: "Select Sub Category", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                  } else if (username_controller4.text.toString().trim().length == 0) {
                    Fluttertoast.showToast(msg: "Select Description", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
                  } else {
                    apimap["product_name"] = username_controller.text.toString();
                    apimap["category_id"] = _mySelection.toString();
                    apimap["subcategory_id"] = _mySelection2.toString();
                    apimap["description"] = username_controller4.text.toString();
                    print(apimap);

                    setState(() {
                      screenchange = "2";
                    });
                  }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
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
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
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
                              keyboardType: TextInputType.number,
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
                              keyboardType: TextInputType.number,
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    screenchange = "1";
                  });
                },
                child: Align(
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
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    apimap["price"] = username_controller2.text;
                    apimap["qty"] = username_controller3.text;

                    screenchange = "3";
                  });
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

  Widget _DynamicLayout() {
    print("click" + screenchange);
    if (screenchange == "1") {
      return _BasicLayout();
    } else if (screenchange == "2") {
      return _PriceLayout();
    } else if (screenchange == "3") {
      return _Attributelayout();
    } else {
      return _ProductLayout();
    }
  }

  Widget _Attributelayout() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 150,
                      height: 34,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Color(0xFFff5000))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Image(
                        image: AssetImage("assets/images/rectangle_11.png"),
                        height: 34,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Product Attributes Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 20.0, color: Colors.white),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemCount: attributelist.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                        decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20.0),
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  attributelist[index]["title"],
                                  style: style,
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
                        )),
                    _Optionlist(index, attributelist[index]["attr_order"], attributelist[index]["option_list"], attributelist[index]["image_upload"]),
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF00a99d)),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    screenchange = "2";
                  });
                },
                child: Align(
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
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    screenchange = "4";
                  });
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

  Widget _Optionlist(int arrayindex, String attribute_id, List<dynamic> optionlist, String image_upload) {
    optionlist = attributelist[arrayindex]["option_list"];

    return Container(
        decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFF00a99d))),
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: optionlist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onChanged(dynamicbools[arrayindex][index], index, arrayindex, optionlist, attribute_id, image_upload);
                  },
                  child: dynamicbools[arrayindex][index]
                      ? Container(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          margin: EdgeInsets.only(left: 2, right: 2),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                            child: Text(
                              optionlist[index]["option_label"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
                            ),
                          ))
                      : Container(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          margin: EdgeInsets.only(left: 2, right: 2),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Color(0xFFff5000))),
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                            child: Text(
                              optionlist[index]["option_label"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', fontSize: 12.0, color: Colors.white),
                            ),
                          )),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: optionlist.length,
              itemBuilder: (context, index) {
                if (image_upload == "1") {
                  String uploadimageString = "No file Chosen";

                  apimap.forEach((key, value) {
                    if (key.contains("[") && key.contains("attr_image")) {
                      const start = "[";
                      const end = "]";
                      final startIndex = key.lastIndexOf(start);
                      final endIndex = key.indexOf(end, startIndex + start.length);
                      if (key.substring(startIndex + start.length, endIndex) == optionlist[index]["opt_order"]) {
                        if (value == "") {
                          uploadimageString = "No file Chosen";
                        } else {
                          uploadimageString = value;
                        }
                      }
                    }
                  });

                  return GestureDetector(
                      onTap: () {},
                      child: dynamicbools[arrayindex][index]
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                      left: 20,
                                      bottom: 5,
                                    ),
                                    child: Text(
                                      optionlist[index]["option_label"],
                                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 18.0, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                    decoration: new BoxDecoration(color: Color(0xFF0a0f32), borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xFF00a99d))),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            chooseImage(optionlist[index]["opt_order"], attribute_id);
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
                                                  overflow: TextOverflow.ellipsis,
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
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ));
                }

                return null;
              },
            ),
          ],
        ));
  }

  String productimage = "No file chosen";

  Widget _ProductLayout() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
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
              ),
              Container(
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
                      child: Image(
                        image: AssetImage("assets/images/rectangle_11.png"),
                        height: 34,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
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
                      GestureDetector(
                        onTap: () {
                          chooseImage22();
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
                          productimage,
                          overflow: TextOverflow.ellipsis,
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    screenchange = "3";
                  });
                },
                child: Align(
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
              ),
              GestureDetector(
                onTap: () {
                  uploadProduct();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF().then((value) => userid = value);
    this.getSWData();
    this.getAttribute();
  }

  BuildContext dilogcontext;

  Future<String> uploadProduct() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          dilogcontext = context;
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
    var request = http.MultipartRequest('POST', Uri.parse(RestDatasource.save_product));

    apimap.forEach((key, value) async {
      if (key.contains("[") && key.contains("attr_image")) {
        String newkey = key + "[]";
        request.files.add(await http.MultipartFile.fromPath(newkey, value));
      } else if (key.contains("[") && key.contains("product_image")) {
        request.files.add(await http.MultipartFile.fromPath(key, value));
      } else {
        request.fields[key] = value;
      }
    });
    request.fields["user_id"] = userid;
    var res = await request.send();
    var response = await http.Response.fromStream(res);

    if (json.decode(response.body)["status_code"] == 200) {
      Fluttertoast.showToast(msg: "Upload Successfully", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      Navigator.pop(dilogcontext);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyStore(),
      ));
    } else {
      Navigator.pop(dilogcontext);
    }

    print(response.body);

    return res.reasonPhrase;
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
              Column(
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
                  Expanded(
                      child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              _DynamicLayout(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
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

Future<String> getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return
  return prefs.getString('userID');
}
