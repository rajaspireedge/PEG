import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peg/ProductResp.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/productlist.dart';
import 'package:peg/universalmodel.dart';
import 'package:peg/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://esportstesting.com/api/";
  static final SIGNUPURL = BASE_URL + "user/login";
  static final Registor = BASE_URL + "user/register";
  static final forgot_passwordapi = BASE_URL + "user/forgot_password";
  static final get_all_products = BASE_URL + "product/get_all_products";
  static final get_all_categories = BASE_URL + "category/get_all_categories";
  static final get_all_subcategories =
      BASE_URL + "category/get_all_subcategories/";
  static final get_all_players = BASE_URL + "user/get_all_players";
  static final view_product = BASE_URL + "product/view_product/";
  static final add_to_cart_product = BASE_URL + "product/add_to_cart_product";
  static final get_all_cart_products = BASE_URL + "cart/get_all_cart_products/";
  static final get_my_order = BASE_URL + "order/get_my_order/";
  static final cart_product_qty_update =
      BASE_URL + "cart/cart_product_qty_update";

  addStringToSF(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', id);
  }

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return
    return prefs.getString('userID');
  }

  Future<User> login(String username, String password, BuildContext context) {
    return _netUtil.post(SIGNUPURL,
        body: {"email": username, "password": password}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);

        addStringToSF(res["user_data"]["id"].toString());

        getStringValuesSF().then((value) => print(value));
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(
            msg: res["error_message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<dynamic> cart_product_qty_updatess(Map<String, String> map) {
    return _netUtil
        .post(cart_product_qty_update, body: map)
        .then((dynamic res) {
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(
            msg: res["cart_list"]["data_update"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        ;
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(
            msg: res["error_message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        throw new Exception(res);
      }
      return res;
    });
  }

  Future<dynamic> addtocart(Map<String, String> map) {
    return _netUtil.post(add_to_cart_product, body: map).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        ;
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(
            msg: res["error_message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<List<Map<String, dynamic>>> fetchProductList() async {
    http.Response response = await http.get(get_all_products);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(
        json.decode(response.body)['product_list']);
  }

  Future<List<Map<String, dynamic>>> fetchPlayer() async {
    http.Response response = await http.get(get_all_players);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(
        json.decode(response.body)['userslist']);
  }

  Future<List<Map<String, dynamic>>> fetchCART(String id) async {
    http.Response response = await http.get(get_all_cart_products + id);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(
        json.decode(response.body)['cart_list']);
  }

  Future<Map<String, dynamic>> fetchItemdetail(String id) async {
    http.Response response = await http.get(view_product + id);
    if (response.statusCode != 200) return null;
    return Map<String, dynamic>.from(
        json.decode(response.body)["product_data"]);
  }

  Future<Universalmodel> signup(
      String first_name,
      String last_name,
      String display_name,
      String email,
      String friends_mail,
      String team_mail,
      String challenge_mail,
      String password,
      String re_type_password) {
    return _netUtil.post(Registor, body: {
      "first_name": first_name,
      "last_name": last_name,
      "display_name": display_name,
      "email": email,
      "friends_mail": friends_mail,
      "team_mail": team_mail,
      "challenge_mail": challenge_mail,
      "password": password,
      "re_type_password": re_type_password,
    }).then((dynamic res) {
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(
            msg: res["error_message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<Universalmodel> forgot(
    String email,
  ) {
    return _netUtil.post(forgot_passwordapi, body: {
      "email": email,
    }).then((dynamic res) {
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(
            msg: res["error_message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 15,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<List<Map<String, dynamic>>> getMainCat() async {
    http.Response response = await http.get(get_all_categories);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(
        json.decode(response.body)['category_list']);
  }
}
