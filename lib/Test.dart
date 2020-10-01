// Flutter code sample for DropdownButton

// This sample shows a `DropdownButton` with a large arrow icon,
// purple text style, and bold purple underline, whose value is one of "One",
// "Two", "Free", or "Four".
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/dropdown_button.png)

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:peg/RestDatasource.dart';

/// This Widget is the main application widget.
class MyAppNEw extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue;

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(RestDatasource.get_all_categories),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody["category_list"];
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    print(dropdownValue);
    return Center(
        child: new Theme(
            data: new ThemeData(
                canvasColor: Colors.red,
                primaryColor: Colors.black,
                accentColor: Colors.black,
                backgroundColor: Colors.black,
                hintColor: Colors.black),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                focusColor: Colors.white,
                value: dropdownValue,
                onChanged: (newVal) {
                  setState(() {
                    dropdownValue = newVal;
                  });
                },
                items: data.map((item) {
                  return DropdownMenuItem(
                    child: new Text(
                      item['name'],
                    ),
                    value: item['id'],
                  );
                }).toList(),
              ),
            )));
  }
}
