class ProductList {
  String id;
  String name;
  String type;
  String seller_id;
  String is_18;
  String category_id;
  String description;
  String price;
  String final_price;
  String special_price;
  String qty;
  String product_order;
  String fee;
  String int_fee;
  String is_customizable;
  String customizable_tag;
  String customizable_tag_description;
  String game_name;
  String status;
  String created_at;
  String updated_at;
  String image;

  ProductList.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        type = jsonMap['type'],
        seller_id = jsonMap['seller_id'],
        is_18 = jsonMap['is_18'],
        category_id = jsonMap['category_id'],
        description = jsonMap['description'],
        price = jsonMap['price'],
        final_price = jsonMap['final_price'],
        special_price = jsonMap['special_price'],
        qty = jsonMap['qty'],
        product_order = jsonMap['product_order'],
        fee = jsonMap['fee'],
        int_fee = jsonMap['int_fee'],
        is_customizable = jsonMap['is_customizable'],
        customizable_tag = jsonMap['customizable_tag'],
        customizable_tag_description = jsonMap['customizable_tag_description'],
        game_name = jsonMap['game_name'],
        status = jsonMap['status'],
        created_at = jsonMap['created_at'],
        updated_at = jsonMap['updated_at'],
        image = jsonMap['image'];
}
