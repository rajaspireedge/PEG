import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/Add_to_cart.dart';
import 'package:peg/Category.dart';
import 'package:peg/Item_Detail.dart';
import 'package:peg/MembbershipInfo.dart';
import 'package:peg/MyOrder.dart';
import 'package:peg/My_Store.dart';
import 'package:peg/PlayerMembership.dart';
import 'package:peg/PlayerOrder.dart';
import 'package:peg/ProductResp.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/Sell_Product_list.dart';
import 'package:peg/login.dart';
import 'package:peg/main.dart';
import 'package:peg/productlist.dart';
import 'package:http/http.dart' as http;
import 'package:peg/whishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This Widget is the main application widget.

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Homescreen(),
        ),
      ),
    );
  }
}

final username_controllerhome = TextEditingController();

class Homescreen extends StatefulWidget {
  Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

RestDatasource api = new RestDatasource();
TextStyle style =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white);
bool product_list = true;

class _HomescreenState extends State<Homescreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _mySelection;
  String _mySelection2;

  List<dynamic> snapshotproductlist;

  List<dynamic> snapshotplayerlist;

  List data = List(); //edited line
  Map<String, dynamic> userdata = Map();

  List data2 = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_categories),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    var resBody = json.decode(res.body);
    print(res.body);

    setState(() {
      data = resBody["category_list"];
    });

    return "Success";
  }

  Future<String> getUserdetail(String userid) async {
    var res = await http.get(
        Uri.encodeFull(RestDatasource.get_profile_info + userid),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    var resBody = json.decode(res.body);
    print(res.body);

    setState(() {
      userdata.addAll(
          Map<String, dynamic>.from(json.decode(res.body)["user_profile"]));
    });

    return "Success";
  }

  Future<String> getProductList() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_products),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    var resBody = json.decode(res.body);
    print(res.body);

    setState(() {
      snapshotproductlist = resBody["product_list"];
    });

    return "Success";
  }

  Future<String> getProductListBySearch(String category_id,
      String sub_category_id, String product_name, BuildContext context) async {
    api
        .productbysearch(_mySelection, _mySelection2, product_name, context)
        .then((value) => {
              onChange(value),
            });
  }

  void onChange(dynamic res) {
    setState(() {
      snapshotproductlist = res;
    });
  }

  Future<String> getPlayer() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_players),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    var resBody = json.decode(res.body);
    print(res.body);

    setState(() {
      snapshotplayerlist = resBody["userslist"];
    });

    return "Success";
  }

  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 60, 0, 100),
      items: [
        PopupMenuItem<bool>(
          child: InkWell(
            child: Text('Pro Esports Store'),
            onTap: () {
              setState(() {
                product_list = true;
                this.getProductList();

                Navigator.pop(context);
              });
            },
          ),
        ),
        PopupMenuItem<bool>(
          child: InkWell(
            onTap: () {
              setState(() {
                product_list = false;

                this.getPlayer();
                Navigator.pop(context);
              });
            },
            child: Text('Players World Store'),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  Future<String> getsubData(String id) async {
    var res = await http.get(
        Uri.encodeFull(RestDatasource.get_all_subcategories + id),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data2 = resBody["subcategory_list"];
    });

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSWData();
    this.getProductList();
    this.getPlayer();
    getStringValuesSF().then((value) => getUserdetail(value));
  }

  String userid;
  String uploadimage;

  BuildContext dialogcontext;

  Future<String> uploadImage(filename, useris, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          dialogcontext = context;
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

    var request = http.MultipartRequest(
        'POST', Uri.parse(RestDatasource.update_profile_img));
    request.files.add(await http.MultipartFile.fromString('user_id', useris));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    var res = await request.send();

    if (res.statusCode == 200) {
      getStringValuesSF().then((value) => getUserdetail(value));

      Fluttertoast.showToast(
          msg: "Upload Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 15,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white);
      Navigator.pop(dialogcontext);
    } else {
      Navigator.pop(dialogcontext);
    }

    print(res.statusCode);
    return res.reasonPhrase;
  }

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera

    setState(() {
      uploadimage = choosedimage.path;
      uploadImage(uploadimage, userid, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var logo = new AssetImage('assets/images/logo.png');
    var borderimg = new AssetImage('assets/images/borderimg.png');
    var viewmore = new AssetImage('assets/images/viewmore.png');
    var shape_1 = new AssetImage('assets/images/shape_1.png');
    var search_1 = new AssetImage('assets/images/search_1.png');
    var back_1 = new AssetImage('assets/images/back_1.png');
    var download_1 = new AssetImage('assets/images/download_1.png');
    var edit = new AssetImage('assets/images/icons_8_edit_64.png');
    var gotostore = new AssetImage('assets/images/gotostore.png');

    Color color1 = Color(0xFFfc4d20);
    Color color2 = Color(0xFF000001);
    Color color3 = Color(0xFFfc4d00);

    TextStyle hintstyle = TextStyle(
        fontFamily: 'Roboto-Bold', fontSize: 15.0, color: Colors.white);

    final playerusername_controller = TextEditingController();

    getStringValuesSF().then((value) => {userid = value});

    final searchproduct = TextField(
      onChanged: (value) {
        getProductListBySearch(
            _mySelection, _mySelection2, username_controllerhome.text, context);
      },
      style: style,
      controller: username_controllerhome,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(18),
        hintText: "Search product",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    final searchaccount = TextField(
      style: style,
      controller: playerusername_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(18),
        hintText: "Search Account",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    if (snapshotproductlist == null || userdata.isEmpty) {
      return Container(
        color: Color(0xFF0a0f32),
        child: Center(
          child: Loading(
            indicator: BallPulseIndicator(),
            size: 100.0,
            color: Colors.cyan,
          ),
        ),
      );
    }

    if (product_list) {
      return MaterialApp(
        theme: Theme.of(context).copyWith(
          canvasColor: Color(
              0xFF0a0f32), //This will change the drawer background to blue.
          //other styles
        ),
        home: Scaffold(
          backgroundColor: Colors.black,
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF0f1642),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          chooseImage();
                        },
                        child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(userdata["image"]),
                                ))),
                      ),
                      GestureDetector(
                        child: Container(
                          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                          width: 100,
                          alignment: Alignment.bottomRight,
                          child: Image(
                            image: edit,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                      Text(
                        userdata["name"],
                        style: TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        'Account # ' + userdata["account_no"],
                        style: TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 13.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage('assets/images/sydney_opera_house.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Home',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyStore(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/supermarket.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'My Store',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SellProduct(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/sell.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Sell Products',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyOrder(userid),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/order.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'My Orders',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PlayerOrder(userid),
                    ));
                  },
                  leading: Image(
                    image: AssetImage("assets/images/order.png"),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Player Orders',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => CategoryFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/rectangle_10_copy_2.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Category',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => WishListFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/sydney_opera_house.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Wishlist',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PlayerMembershipFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/staff.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Player Membership',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MemberShipFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/membership.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Membership info',
                    style: style,
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 30.0, 2.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: borderimg, fit: BoxFit.fill),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          child: Text(
                            "Available balance :" + userdata["total_balance"],
                            style: TextStyle(
                                fontFamily: 'Roboto-Bold',
                                fontSize: 15.0,
                                color: Color(0xFF6ae7e0)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState.openDrawer();
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(30.0, 25.0, 0.0, 0.0),
                            child: Image(
                              image: AssetImage("assets/images/menu.png"),
                              height: 30,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Image(
                            image: logo,
                            height: 80,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 25.0, 30.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  child: Image(
                                    image: AssetImage("assets/images/post.png"),
                                    height: 20,
                                    width: 30,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Addtocart(
                                                id: userid,
                                              )));
                                },
                                child: Container(
                                  child: Image(
                                    image: AssetImage("assets/images/cart.png"),
                                    height: 20,
                                    width: 30,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _showPopupMenu(context);
                                },
                                child: Container(
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/more1.png"),
                                    height: 20,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
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
                                margin: EdgeInsets.only(right: 30.0),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: searchproduct,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 30.0),
                                child: Image(
                                  image: search_1,
                                  height: 20,
                                  width: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
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
                                margin: EdgeInsets.only(right: 30.0, left: 20),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
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
                                margin: EdgeInsets.only(right: 30.0, left: 20),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
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
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(30),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (_, index) => Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Stack(
                          children: <Widget>[
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
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Material(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0)),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            type: MaterialType.transparency,
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 30),
                                                height: 25,
                                                child: Stack(
                                                  children: [
                                                    Image(
                                                      image: shape_1,
                                                      fit: BoxFit.cover,
                                                      color: Color(0xFFfc4d00),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          snapshotproductlist[
                                                                      index]
                                                                  ["name"] ??
                                                              'Name',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto-Bold',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10.0,
                                                              color: Colors
                                                                  .black)),
                                                      width: 140,
                                                      margin: EdgeInsets.only(
                                                          left: 1),
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      Align(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 30,
                                              bottom: 45,
                                              left: 10,
                                              right: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      snapshotproductlist[index]
                                                          ["image"]),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ItemFull(
                                                            id: snapshotproductlist[
                                                                index]["id"])));
                                          },
                                          child: Image(
                                            image: viewmore,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      itemCount: snapshotproductlist.length,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return MaterialApp(
        theme: Theme.of(context).copyWith(
          canvasColor: Color(
              0xFF0a0f32), //This will change the drawer background to blue.
          //other styles
        ),
        home: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF0f1642),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(userdata["image"]),
                              ))),
                      Container(
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        width: 100,
                        alignment: Alignment.bottomRight,
                        child: Image(
                          image: edit,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Text(
                        userdata["name"],
                        style: TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      Text(
                        'Account # ' + userdata["account_no"],
                        style: TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 13.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage('assets/images/sydney_opera_house.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Home',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyStore(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/supermarket.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'My Store',
                    style: style,
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage('assets/images/sell.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Sell Products',
                    style: style,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SellProduct(),
                    ));
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyOrder(userid),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/order.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'My Orders',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PlayerOrder(userid),
                    ));
                  },
                  leading: Image(
                    image: AssetImage("assets/images/order.png"),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Player Orders',
                    style: style,
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage('assets/images/rectangle_10_copy_2.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Category',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => WishListFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/sydney_opera_house.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Wishlist',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PlayerMembershipFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/staff.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Player Membership',
                    style: style,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MemberShipFull(),
                    ));
                  },
                  leading: Image(
                    image: AssetImage('assets/images/membership.png'),
                    height: 20,
                    width: 40,
                  ),
                  title: Text(
                    'Membership info',
                    style: style,
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/allbg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 30.0, 2.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: borderimg, fit: BoxFit.fill),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          child: Text(
                            "Available balance :" + userdata["total_balance"],
                            style: TextStyle(
                                fontFamily: 'Roboto-Bold',
                                fontSize: 10.0,
                                color: Color(0xFF6ae7e0)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                          child: Image(
                            image: AssetImage("assets/images/menu.png"),
                            height: 30,
                            width: 50,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Image(
                          image: logo,
                          height: 100,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                child: Image(
                                  image: AssetImage("assets/images/post.png"),
                                  height: 20,
                                  width: 30,
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                child: Image(
                                  image: AssetImage("assets/images/cart.png"),
                                  height: 20,
                                  width: 30,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _showPopupMenu(context);
                              },
                              child: Container(
                                child: Image(
                                  image: AssetImage("assets/images/more1.png"),
                                  height: 20,
                                  width: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
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
                                margin: EdgeInsets.only(right: 30.0),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: searchaccount,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 30.0),
                                child: Image(
                                  image: search_1,
                                  height: 20,
                                  width: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(30),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        if (snapshotplayerlist == null || userdata.isEmpty) {
                          return Container(
                            color: Colors.lightBlue,
                            child: Center(
                              child: Loading(
                                  indicator: BallPulseIndicator(),
                                  size: 100.0,
                                  color: color3),
                            ),
                          );
                        }
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image(
                                      image: download_1,
                                      height: 60,
                                      width: 60,
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  "Account # " +
                                          snapshotplayerlist[index]["id"] ??
                                      'id',
                                  style: TextStyle(
                                      fontFamily: 'Roboto-Bold',
                                      fontSize: 15.0,
                                      color: Colors.deepOrange),
                                ),
                              ),
                              Container(
                                child: Text(
                                  snapshotplayerlist[index]["display_name"] ??
                                      'Name',
                                  style: TextStyle(
                                      fontFamily: 'Roboto-Bold',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                                child: Image(
                                  image: gotostore,
                                  height: 40,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF0a0f32),
                              border: Border.all(color: color3),
                              borderRadius: BorderRadius.circular(10.0)),
                        );
                      },
                      itemCount: snapshotplayerlist.length,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    @required double strokeWidth,
    @required double radius,
    @required Gradient gradient,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
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

TextStyle dropdownstyle = TextStyle(
    fontFamily: 'Roboto-Bold', fontSize: 10.0, color: Color(0xFF06cdff));

class DropDown extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {}
}

Future<String> getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return
  return prefs.getString('userID');
}
