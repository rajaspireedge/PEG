import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/login.dart';

class SignUp extends StatelessWidget {
  ViewStatefull createState() => ViewStatefull();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: ViewStatefull(),
    )));
  }
}

class ViewStatefull extends StatefulWidget {
  @override
  ViewSignupState createState() => ViewSignupState();
}

class ViewSignupState extends State {
  bool officon1 = true;
  bool onicon1 = false;

  bool officon2 = true;
  bool onicon2 = false;

  bool officon3 = true;
  bool onicon3 = false;

  String friendmail = "0";
  String esportmail = "0";
  String challengemail = "0";

  RestDatasource api = new RestDatasource();

  @override
  Widget build(BuildContext context) {
    var borderimg = new AssetImage('assets/images/borderimg.png');
    var logo = new AssetImage('assets/images/logo.png');
    var switchbg = new AssetImage('assets/images/switchbg.png');
    var on = new AssetImage('assets/images/on.png');
    var off = new AssetImage('assets/images/off.png');

    Color color1 = Color(0xFF06cdff);

    final firstname_controller = TextEditingController();
    final lastname_controller = TextEditingController();
    final display_controller = TextEditingController();
    final email_controller = TextEditingController();
    final password_controller = TextEditingController();
    final retypepassword_controller = TextEditingController();

    final firstname = TextField(
      style: style,
      controller: firstname_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "First name",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );
    final lastname = TextField(
      style: style,
      controller: lastname_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Last name",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );
    final displayname = TextField(
      style: style,
      controller: display_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Display name",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    final emailname = TextField(
      style: style,
      controller: email_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email ID",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    final password = TextField(
      style: style,
      obscureText: true,
      controller: password_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    final retypepassword = TextField(
      style: style,
      obscureText: true,
      controller: retypepassword_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Retype Password",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    return Scaffold(
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/allbg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                        child: Image(
                          image: logo,
                          height: 350,
                          width: 350,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: firstname,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: lastname,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: displayname,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: emailname,
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(40.0, 15.0, 0.0, 0.0),
                          child: Text("Email Notifications",
                              style: TextStyle(
                                  fontFamily: 'Roboto-Bold',
                                  fontSize: 15.0,
                                  color: color1))),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                    child: Text("Friends Mail",
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Bold',
                                            fontSize: 8.0,
                                            color: Colors.white))),
                                Stack(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        if (officon1) {
                                          setState(() {
                                            onicon1 = true;
                                            officon1 = false;
                                            friendmail = "1";
                                          });
                                        } else {
                                          setState(() {
                                            onicon1 = false;
                                            officon1 = true;
                                            friendmail = "0";
                                          });
                                        }
                                      },
                                      child: new Image(
                                        image: switchbg,
                                        height: 50,
                                        width: 70,
                                      ),
                                    ),
                                    Visibility(
                                        visible: officon1,
                                        child: Image(
                                          image: off,
                                          height: 50,
                                          width: 20,
                                        )),
                                    Visibility(
                                        visible: onicon1,
                                        child: Positioned(
                                          left: 50,
                                          child: new Image(
                                            image: on,
                                            height: 50,
                                            width: 20,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                    child: Text("Esports Team Mail",
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Bold',
                                            fontSize: 8.0,
                                            color: Colors.white))),
                                Stack(
                                  children: <Widget>[
                                    InkWell(
                                      child: new Image(
                                        image: switchbg,
                                        height: 50,
                                        width: 70,
                                      ),
                                      onTap: () {
                                        if (officon2) {
                                          setState(() {
                                            onicon2 = true;
                                            officon2 = false;
                                            esportmail = "1";
                                          });
                                        } else {
                                          setState(() {
                                            onicon2 = false;
                                            officon2 = true;
                                            esportmail = "0";
                                          });
                                        }
                                      },
                                    ),
                                    Visibility(
                                        visible: officon2,
                                        child: Image(
                                          image: off,
                                          height: 50,
                                          width: 20,
                                        )),
                                    Visibility(
                                        visible: onicon2,
                                        child: Positioned(
                                          left: 50,
                                          child: new Image(
                                            image: on,
                                            height: 50,
                                            width: 20,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                    child: Text("Challenge Mail",
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Bold',
                                            fontSize: 8.0,
                                            color: Colors.white))),
                                Stack(
                                  children: <Widget>[
                                    InkWell(
                                      child: new Image(
                                        image: switchbg,
                                        height: 50,
                                        width: 70,
                                      ),
                                      onTap: () {
                                        if (officon3) {
                                          setState(() {
                                            onicon3 = true;
                                            officon3 = false;
                                            challengemail = "1";
                                          });
                                        } else {
                                          setState(() {
                                            onicon3 = false;
                                            officon3 = true;
                                            challengemail = "0";
                                          });
                                        }
                                      },
                                    ),
                                    Visibility(
                                        visible: officon3,
                                        child: Image(
                                          image: off,
                                          height: 50,
                                          width: 20,
                                        )),
                                    Visibility(
                                        visible: onicon3,
                                        child: Positioned(
                                          left: 50,
                                          child: new Image(
                                            image: on,
                                            height: 50,
                                            width: 20,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: password,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: retypepassword,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: Stack(
                                children: <Widget>[
                                  new Image(
                                    image: new AssetImage(
                                        "assets/images/signup.png"),
                                    height: 100,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              onTap: () => api.signup(
                                  firstname_controller.text,
                                  lastname_controller.text,
                                  display_controller.text,
                                  email_controller.text,
                                  friendmail,
                                  esportmail,
                                  challengemail,
                                  password_controller.text,
                                  retypepassword_controller.text),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                height: 100,
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: Text("Already a User?",
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Bold',
                                                fontSize: 12.0,
                                                color: Colors.white))),
                                    Container(
                                        child: Text("Sign in",
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Bold',
                                                fontSize: 12.0,
                                                color: color1)))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          onWillPop: () async {
            return Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Login()));
          }),
    );
  }
}
