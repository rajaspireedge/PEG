import 'dart:core';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:peg/MyOrder.dart';
import 'package:peg/homescreen.dart';
import 'package:peg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaymentScreen.dart';
import 'PaypalServices.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  Map<String, dynamic> map = new Map();

  PaypalPayment(this.map, {this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState(map);
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  Map<String, dynamic> map = new Map();

  PaypalPaymentState(this.map);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;

  String loading = "";

  Map<String, String> apimap = new Map();
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        print(getOrderParams());
        final transactions = getOrderParams();
        final res = await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {"name": itemName, "quantity": quantity, "price": itemPrice, "currency": defaultCurrency["currency"]}
    ];

    // checkout invoice details
    String totalAmount = '1.99';
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Raj';
    String userLastName = 'Rajput';
    String addressCity = 'Ahmedabad';
    String addressStreet = 'Mehsana';
    String addressZipCode = '384001';
    String addressCountry = 'India';
    String addressState = 'Gujarat';
    String addressPhoneNumber = '+919687296871';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": map["subscribe_amount"],
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": map["subscribe_amount"],
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {"allowed_payment_method": "INSTANT_FUNDING_SOURCE"},
          "item_list": {
            "items": map["cartitem"],
            if (isEnableShipping && isEnableAddress) "shipping_address": {"recipient_name": map["name"], "line1": map["shipping_details"][0]["address"], "line2": "", "city": map["city"], "country_code": map["shipping_details"][0]["countrycode"], "postal_code": "", "phone": map["phone"], "state": map["shipping_details"][0]["state"]},
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  void paymentpaypal(dynamic number, String userid) {
    String transactions_id = number["transactions"][0]["related_resources"][0]["sale"]["id"].toString();
    String payer_id = number["payer"]["payer_info"]["payer_id"].toString();
    print('order id: ' + transactions_id);

    apimap["user_id"] = userid;
    apimap["name"] = map["name"];
    apimap["email"] = map["email"];
    apimap["phone"] = map["phone"];
    apimap["wallet_amount"] = "0";

    apimap["payment_method"] = "paypal";
    apimap["ref_id"] = map["ref_id"];
    apimap["seller_id"] = map["seller_id"];
    apimap["payer_id"] = payer_id;
    apimap["transaction_id"] = transactions_id;
    apimap["paypal_deducted"] = map["subscribe_amount"];
    apimap["shippaddress"] = map["shipping_details"][0]["address"].toString();
    apimap["billaddress"] = map["shipping_details"][0]["address"];
    apimap["order_subtotal"] = map["subscribe_amount"];
    apimap["order_shipping_fee"] = map["shipping_charge"];
    apimap["order_total"] = map["subscribe_amount"];
    apimap["shipping_address"] = map["shipping_details"][0]["address"];
    apimap["shipping_country"] = map["shipping_details"][0]["country"];
    apimap["shipping_state"] = map["shipping_details"][0]["state"];
    apimap["shipping_city"] = map["shipping_details"][0]["city"];
    apimap["shipping_phone"] = map["phone"];
    apimap["billing_address"] = map["shipping_details"][0]["address"];
    apimap["billing_country"] = map["shipping_details"][0]["country"];
    apimap["billing_state"] = map["shipping_details"][0]["state"];
    apimap["billing_city"] = map["shipping_details"][0]["city"];
    apimap["billing_phone"] = map["phone"];

    api.paypal_response(apimap, context);
  }

  @override
  Widget build(BuildContext context) {
    print("checkoutUrl" + checkoutUrl.toString());

    if(loading == "1"){
      return Container(
        color: Color(0xFF0a0f32),
        child: Center(
          child: Loading(
              indicator: BallPulseIndicator(), size: 100.0, color: color3),
        ),
      );
    }

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services.executePayment(executeUrl, payerID, accessToken).then((id) {

                  widget.onFinish(id);
                  setState(() {
                    loading = "1";
                  });
                  getStringValuesSF().then((value) => paymentpaypal(id, value));
                  print("444");
                });
              } else {
                print("111");
              }

              print("222");
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                print("333");
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}

loader() {
  return Container(
    color: Color(0xFF0a0f32),
    child: Center(
      child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: color3),
    ),
  );
}
