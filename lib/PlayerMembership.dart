import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

import 'package:peg/MyOrderDetail.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/main.dart';

class PlayerMembership extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: PlayerMembershipFull(),
      ),
    ));
  }
}

class PlayerMembershipFull extends StatefulWidget {
  @override
  _PlayerMembershipFullState createState() => _PlayerMembershipFullState();
}

class _PlayerMembershipFullState extends State<PlayerMembershipFull> {
  List<Map<String, dynamic>> snapshotitemlist;
  Map<String, dynamic> usersnapshotitemlist;

  List idlist = new List();
  Map<int, bool> dynamicbools = Map();

  Future<String> getSWData(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_membership_list), headers: {"Accept": "application/json"});

    setState(() {
      snapshotitemlist = List<Map<String, dynamic>>.from(json.decode(res.body)['membership_list']);

      for (int i = 0; i < snapshotitemlist.length; i++) {
        idlist.add(snapshotitemlist[i]["id"].toString());
        dynamicbools[i] = false;
      }
      getStringValuesSF().then((value) => this.getSWData222(value));
    });
    return "Success";
  }

  Future<String> getSWData222(String id) async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_user_membership + id), headers: {"Accept": "application/json"});

    setState(() {
      usersnapshotitemlist = Map<String, dynamic>.from(json.decode(res.body)['user_plan_data']);

      if (idlist.contains(usersnapshotitemlist["plan_id"].toString())) {
        for (int i = 0; i < snapshotitemlist.length; i++) {
          if (usersnapshotitemlist["plan_id"].toString() == snapshotitemlist[i]["id"].toString()){
            setState(() {
              dynamicbools[i] = true;
              print(dynamicbools[i]);
            });
          }
        }
      }
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF().then((value) => this.getSWData(value));
  }

  @override
  Widget build(BuildContext context) {
    Color color3 = Color(0xFF6ae7e0);
    if (snapshotitemlist == null) {
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
                              "Player Membership",
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Bold', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                          child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 30, left: 30, bottom: 10, top: 20),
                                child: Stack(
                                  overflow: Overflow.visible,
                                  fit: StackFit.loose,
                                  children: [
                                    Image(image: AssetImage("assets/images/rounded_rectangle_1.png"), fit: BoxFit.fill),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        transform: Matrix4.translationValues(-10, -15, 0),
                                        child: Image(image: AssetImage("assets/images/i.png"), height: 35, width: 35, fit: BoxFit.fill),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Image(image: NetworkImage(snapshotitemlist[index]["image"]), height: 130, width: 130, fit: BoxFit.cover),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                snapshotitemlist[index]["title"],
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 10.0, color: Color(0xFFff5000)),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                "Amount : 20.00",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto-Medium', letterSpacing: 0.03, fontSize: 12.0, color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10, top: 10),
                                              child: Image(image: dynamicbools[index] ? AssetImage("assets/images/subscribe2.png") : AssetImage("assets/images/subscribe.png"), height: 25, width: 100, fit: BoxFit.cover),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: snapshotitemlist.length,
                          ),
                        ],
                      )),
                    ),
                  )
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
