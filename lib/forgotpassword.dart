import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/login.dart';

class Forgot_Password extends StatefulWidget {
  @override
  _Forgot_PasswordState createState() => _Forgot_PasswordState();
}

var borderimg = new AssetImage('assets/images/borderimg.png');
var logo = new AssetImage('assets/images/logo.png');

var submit = new AssetImage('assets/images/submit.png');

const Color color1 = Color(0xFF7d98f9);

RestDatasource api = RestDatasource();

TextStyle style =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 16.0, color: Colors.white);

TextStyle hintstyle =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 16.0, color: Colors.white);

final email_controller = TextEditingController();

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

class _Forgot_PasswordState extends State<Forgot_Password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SingleChildScrollView(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: logo,
                      height: 200,
                      width: 200,
                    ),
                    Container(
                        child: Text(
                      "Enter your registerecd Email ID , we will\nsend you instructions to reset your\npassword",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 15.0,
                          color: color1),
                      textAlign: TextAlign.center,
                    )),
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
                      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: new InkWell(
                        onTap: () {
                          api.forgot(email_controller.text);
                        },
                        child: new Image(
                          image: submit,
                          height: 100,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: null,
      ),
    );
  }
}
