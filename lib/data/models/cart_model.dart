import 'package:crafty_bay/data/models/product_model.dart';

class CartModel {
  int? id;
  int? userId;
  int? productId;
  String? color;
  String? size;
  int? qty;
  String? price;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  CartModel(
      {this.id,
      this.userId,
      this.productId,
      this.color,
      this.size,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['email'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    createdAt = json['created_at'];
    qty = int.tryParse(json['qty']) ?? 1;
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (userId != null) data['user_id'] = userId;
    if (productId != null) data['product_id'] = productId;
    if (color != null) data['color'] = color;
    if (size != null) data['size'] = size;
    if (qty != null) data['qty'] = qty ?? 1;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }

    return data;
  }
}
