import 'package:nem_pho/models/product_model.dart';

class OrderModel {
  final String status;
  final List<ProductModel> products;

  OrderModel({
    required this.status,
    required this.products
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'],
      products: List<ProductModel>.from(json['products'].map((x) =>
          ProductModel.fromJson(x)
      )),
    );
  }
}