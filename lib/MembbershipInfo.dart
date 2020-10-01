import 'package:flutter/material.dart';

class MemberShip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(),
    ));
  }
}

class MemberShipFull extends StatefulWidget {
  @override
  _MemberShipFullState createState() => _MemberShipFullState();
}

class _MemberShipFullState extends State<MemberShipFull> {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                "Membership Info",
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
                      margin: EdgeInsets.only(left: 10),
                      child: Image(
                          image: AssetImage("assets/images/demo1.png"),
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "Donate Monthly 3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto-Medium',
                            letterSpacing: 0.03,
                            fontSize: 25.0,
                            color: Color(0xFFff5000)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "NEW Help Development of the Site & help maintain\nsponsored Streamers",
                        style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            letterSpacing: 0.03,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto-Medium',
                            letterSpacing: 0.03,
                            fontSize: 25.0,
                            color: Color(0xFFff5000)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 30 , left: 30),
                      child: Text(
                        "1. Payments are Automatic until Cancelled.\n\n2. Their are no refunds for Donations when\ncancelled.",
                        style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            letterSpacing: 0.03,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
          onWillPop: () async {}),
    );
  }
}
