import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peg/RestDatasource.dart';
import 'package:peg/forgotpassword.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/signup.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final username_controller = TextEditingController();
    final password_controller = TextEditingController();

    RestDatasource api = new RestDatasource();

    var borderimg = new AssetImage('assets/images/borderimg.png');
    var loginimg = new AssetImage('assets/images/loginimg.png');
    var logo = new AssetImage('assets/images/logo.png');

    final passwordFields = TextField(
        style: style,
        controller: password_controller,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: InputBorder.none,
          hintStyle: hintstyle,
        ));

    Color color1 = Color(0xFF06cdff);

    final emailFields = TextField(
      style: style,
      controller: username_controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email ID",
        border: InputBorder.none,
        hintStyle: hintstyle,
      ),
    );

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/allbg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image(
                    image: logo,
                    height: 350,
                    width: 350,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: emailFields,
                      )
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: borderimg,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: passwordFields,
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Forgot_Password())),
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 50.0, 0.0),
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              fontFamily: 'Roboto-Bold',
                              fontSize: 15.0,
                              color: color1)),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: new InkWell(
                                  onTap: () => api
                                      .login(username_controller.text,
                                          password_controller.text, context)
                                      .then((value) => Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Homescreen()))),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: new Image(
                                          image: loginimg,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        child: Container(
                                          height: 150,
                                          margin: EdgeInsets.only(top: 60),
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () => Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            SignUp())),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text("SIGN UP",
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto-Bold',
                                                      fontSize: 15.0,
                                                      color: color1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

const TextStyle style =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white);

const TextStyle dropdownstyle =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: color1);

TextStyle hintstyle =
    TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14.0, color: Colors.white);
