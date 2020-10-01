import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/MyOrderDetail.dart';
import 'package:peg/homescreen.dart';

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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              right: 30, left: 30, bottom: 10, top: 20),
                          child: Stack(
                            overflow: Overflow.visible,
                            fit: StackFit.loose,
                            children: [
                              Image(
                                  image: AssetImage(
                                      "assets/images/rounded_rectangle_1.png"),
                                  fit: BoxFit.fill),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  transform:
                                      Matrix4.translationValues(-10, -15, 0),
                                  child: Image(
                                      image: AssetImage("assets/images/i.png"),
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/demo1.png"),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.fill),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only( top: 10),
                                        child: Text(
                                          "Donate Monthly 3",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto-Medium',
                                              letterSpacing: 0.03,
                                              fontSize: 15.0,
                                              color: Color(0xFFff5000)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only( top: 10),
                                        child: Text(
                                          "Amount : 20.00",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto-Medium',
                                              letterSpacing: 0.03,
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10 , top: 10),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/images/subscribe.png"),
                                            height: 35,
                                            width: 120,
                                            fit: BoxFit.cover),
                                      ),
                                    ],
                                  ),

                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ],
                )),
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
