import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peg/MyOrder.dart';
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
  static final get_all_subcategories = BASE_URL + "category/get_all_subcategories/";
  static final get_all_players = BASE_URL + "user/get_all_players";
  static final view_product = BASE_URL + "product/view_product/";
  static final add_to_cart_product = BASE_URL + "product/add_to_cart_product";
  static final add_to_wishlist_product = BASE_URL + "product/add_to_wishlist_product";
  static final get_all_cart_products = BASE_URL + "cart/get_all_cart_products/";
  static final get_profile_info = BASE_URL + "user/get_profile_info/";
  static final get_my_order = BASE_URL + "order/get_my_order/";
  static final get_my_order_details = BASE_URL + "order/get_my_order_details/";
  static final get_player_order = BASE_URL + "order/get_player_order/";
  static final wishlist = BASE_URL + "wishlist/get_products/";
  static final cart_product_delete = BASE_URL + "cart/cart_product_delete/";
  static final delete_wishlist_product = BASE_URL + "wishlist/delete_wishlist_product/";
  static final paypal_requestapi = BASE_URL + "checkout/paypal_request";
  static final paypal_responseapi = BASE_URL + "checkout/paypal_response";
  static final get_store_overview = BASE_URL + "store/get_store_overview/";
  static final get_store_level = BASE_URL + "store/get_store_level/";
  static final update_store_banner = BASE_URL + "store/update_store_banner";
  static final update_store_link = BASE_URL + "store/update_store_link";
  static final delete_product = BASE_URL + "product/delete_product/";
  static final delete_categories = BASE_URL + "category/delete_categories/";
  static final update_player_international_tax = BASE_URL + "product/update_player_international_tax";
  static final add_category_api = BASE_URL + "category/add_category";
  static final add_subcategory = BASE_URL + "category/add_subcategory";
  static final edit_category = BASE_URL + "category/edit_category";
  static final get_membership_list = BASE_URL + "membership/get_membership_list";
  static final get_user_membership = BASE_URL + "membership/get_user_membership/";
  static final get_product_list_by_search = BASE_URL + "product/get_product_list_by_search";
  static final update_tacking_info = BASE_URL + "order/update_tacking_info";
  static final cancel_my_order = BASE_URL + "order/cancel_my_order";
  static final add_to_cart_from_wishlist_product = BASE_URL + "wishlist/add_to_cart_from_wishlist_product/";
  static final category_status_update = BASE_URL + "category/category_status_update";
  static final update_player_local_tax = BASE_URL + "product/update_player_local_tax";
  static final cart_product_qty_update = BASE_URL + "cart/cart_product_qty_update";
  static final get_attributes = BASE_URL + "attributes/get_attributes";

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
    return _netUtil.post(SIGNUPURL, body: {"email": username, "password": password}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);

        addStringToSF(res["user_data"]["id"].toString());

        getStringValuesSF().then((value) => print(value));
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> updatestorelink(String userid, String storelink, BuildContext context) {
    return _netUtil.post(update_store_link, body: {"user_id": userid, "store_link": storelink}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["data"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> update_tacking_infoAPI(String editid, String edit_traking_id, String item_sold_by, String grand_total, String ref_seller, BuildContext context) {
    return _netUtil.post(update_tacking_info, body: {"editid": editid, "edit_traking_id": edit_traking_id, "item_sold_by": item_sold_by, "grand_total": grand_total, "ref_seller": ref_seller}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["data"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> updatelocaltax(String userid, String type, String value, BuildContext context) {
    return _netUtil.post(update_player_local_tax, body: {"user_id": userid, "type": type, "value": value}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> cancelorder(String order_id, BuildContext context) {
    return _netUtil.post(cancel_my_order, body: {"order_id": order_id}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["order_list"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> add_category(String userid, String name, BuildContext context) {
    return _netUtil.post(add_category_api, body: {
      "user_id": userid,
      "name": name,
    }).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> add_category22(String userid, String parentid, String name, BuildContext context) {
    return _netUtil.post(add_subcategory, body: {
      "user_id": userid,
      "parent_id": parentid,
      "name": name,
    }).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> edit_cat(String userid, String name, BuildContext context) {
    return _netUtil.post(edit_category, body: {
      "id": userid,
      "name": name,
    }).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> category_status_updatess(String userid, String name, BuildContext context) {
    print(userid);
    print(name);

    return _netUtil.post(category_status_update, body: {
      "id": userid,
      "status": name,
    }).then((dynamic res) {
      Navigator.pop(context);

      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<User> edit_cat22(String userid, String parentid, String name, BuildContext context) {
    return _netUtil.post(edit_category, body: {
      "id": userid,
      "parent_id": parentid,
      "name": name,
    }).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<List<dynamic>> productbysearch(String category_id, String sub_category_id, String product_name, BuildContext context) {
    if (category_id == null) {
      category_id = "";
    }
    if (sub_category_id == null) {
      sub_category_id = "";
    }

    return _netUtil.post(get_product_list_by_search, body: {
      "category_id": category_id,
      "sub_category_id": sub_category_id,
      "product_name": product_name,
    }).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        return res['product_list'];
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return res['product_list'];
    });
  }

  Future<User> updateinternationaltax(String userid, String type, String value, BuildContext context) {
    return _netUtil.post(update_player_international_tax, body: {"user_id": userid, "type": type, "value": value}).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<dynamic> cart_product_qty_updatess(Map<String, String> map) {
    return _netUtil.post(cart_product_qty_update, body: map).then((dynamic res) {
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: res["cart_list"]["data_update"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        ;
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return res;
    });
  }

  Future<dynamic> paypal_request(Map<String, String> map) {
    return _netUtil.post(paypal_requestapi, body: map).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: "Order is placed", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return res;
    });
  }

  Future<dynamic> paypal_response(Map<String, String> map, BuildContext context) {
    return _netUtil.post(paypal_responseapi, body: map).then((dynamic res) {
      print(res);
      getStringValuesSF().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyOrder(value)), (Route<dynamic> route) => false));
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return res;
    });
  }

  Future<dynamic> addtocart(Map<String, String> map) {
    print(map);
    return _netUtil.post(add_to_cart_product, body: map).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        ;
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<dynamic> addtowishlist(Map<String, String> map) {
    print(map);
    return _netUtil.post(add_to_wishlist_product, body: map).then((dynamic res) {
      print(res);
      if (res["status_code"] == 200) {
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        ;
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<List<Map<String, dynamic>>> fetchSellProductList(String user_id) async {
    http.Response response = await http.get(get_all_products + "/" + user_id);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(json.decode(response.body)['product_list']);
  }

  Future<List<Map<String, dynamic>>> fetchCART(String id) async {
    http.Response response = await http.get(get_all_cart_products + id);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(json.decode(response.body)['cart_list']);
  }

  Future<Map<String, dynamic>> fetchItemdetail(String id) async {
    http.Response response = await http.get(view_product + id);
    if (response.statusCode != 200) return null;
    return Map<String, dynamic>.from(json.decode(response.body)["product_data"]);
  }

  Future<Map<String, dynamic>> deletecart(String userid, String cartid) async {
    http.Response res = await http.delete(cart_product_delete + userid + "/" + cartid);
    if (json.decode(res.body)["status_code"] == 200) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
    }
    if (json.decode(res.body)["status_code"] == 400) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      throw new Exception(res);
    }
  }

  Future<Map<String, dynamic>> deletewishlist(String userid, String cartid, BuildContext context) async {
    http.Response res = await http.delete(delete_wishlist_product + cartid);

    Navigator.pop(context);

    if (json.decode(res.body)["status_code"] == 200) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
    }
    if (json.decode(res.body)["status_code"] == 400) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      throw new Exception(res);
    }
  }

  Future<Map<String, dynamic>> deleteproduct(String product_id) async {
    http.Response res = await http.delete(delete_product + "/" + product_id);
    if (json.decode(res.body)["status_code"] == 200) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
    }
    if (json.decode(res.body)["status_code"] == 400) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      throw new Exception(res);
    }
  }

  Future<Map<String, dynamic>> deletecat(String cat_id) async {
    http.Response res = await http.delete(delete_categories + "/" + cat_id);
    if (json.decode(res.body)["status_code"] == 200) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
    }
    if (json.decode(res.body)["status_code"] == 400) {
      Fluttertoast.showToast(msg: json.decode(res.body)["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      throw new Exception(res);
    }
  }

  Future<Universalmodel> signup(String first_name, String last_name, String display_name, String email, String friends_mail, String team_mail, String challenge_mail, String password, String re_type_password) {
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
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
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
        Fluttertoast.showToast(msg: res["message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
      }
      if (res["status_code"] == 400) {
        Fluttertoast.showToast(msg: res["error_message"], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 15, timeInSecForIos: 1, backgroundColor: Colors.blue, textColor: Colors.white);
        throw new Exception(res);
      }
      return;
    });
  }

  Future<List<Map<String, dynamic>>> getMainCat() async {
    http.Response response = await http.get(get_all_categories);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(json.decode(response.body)['category_list']);
  }
}
