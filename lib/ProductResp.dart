import 'package:peg/productlist.dart';

class ProductRes {
  String status;
  String status_code;
  ProductList productlist;

  ProductRes(this.status, this.status_code, this.productlist);

  ProductRes.fromJSON(Map<String, dynamic> jsonMap)
      : status = jsonMap['status'],
        status_code = jsonMap['status_code'],
        productlist = jsonMap['productlist'];
}
