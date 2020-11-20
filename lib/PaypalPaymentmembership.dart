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

class PaypalPaymentmembership extends StatefulWidget {
  final Function onFinish;
  int map = 0;

  PaypalPaymentmembership(this.map, {this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState(map);
  }
}

class PaypalPaymentState extends State<PaypalPaymentmembership> {
  int map = 0;

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
            "total": map,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": map,
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {"allowed_payment_method": "INSTANT_FUNDING_SOURCE"},
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
