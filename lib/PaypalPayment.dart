import 'dart:core';
import 'package:flutter/material.dart';
import 'package:peg/MyOrder.dart';
import 'package:peg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        print(transactions);

        final res =
        await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
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
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
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

    print( map["subscribe_amount"]);

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": map["subscribe_amount"].toString(),
            "currency": defaultCurrency["currency"].toString(),
            "details": {
              "subtotal": map["subscribe_amount"].toString(),
              "shipping": map["shipping_charge"].toString(),
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": map["items"],
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": map["name"].toString(),
                "line1": map["shipping_details"][0]["address"].toString(),
                "line2": "",
                "city": map["city"].toString()
                ,
                "country_code": map["shipping_details"][0]["countrycode"].toString(),
                "postal_code": "",
                "phone": map["phone"].toString(),
                "state": map["shipping_details"][0]["state"].toString()
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": map["returnurl"].toString(),
        "cancel_url": map["cancelurl"].toString()
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print("checkoutUrl" + checkoutUrl.toString());

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
            if (request.url.contains(map["returnurl"])) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();

                  print("444");
                });
              } else {
                print("111");
                Navigator.of(context).pop();
              }

              print("222");

              getStringValuesSF().then((value) => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MyOrder(value))));
            }
            if (request.url.contains(map["cancelurl"])) {
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
