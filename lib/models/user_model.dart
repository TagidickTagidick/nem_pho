import 'product_model.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.phone,
    required this.dateOfBirth,
    required this.sex,
    required this.street,
    required this.apartment,
    required this.entrance,
    required this.floor,
    required this.orders,
    required this.cart,
  });

  final String name;
  final String phone;
  final String dateOfBirth;
  final bool? sex;
  final String street;
  final String apartment;
  final String entrance;
  final String floor;
  final List<OrderModel> orders;
  final List<ProductModel> cart;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    List<OrderModel> orders = [];
    if (json['orders'] != null) {
      (json['orders'] as Map).forEach((key, value) {
        orders.add(OrderModel.fromJson(value, int.parse(key)));
      });
    }
    List<ProductModel> cart = [];
    if (json['cart'] != null) {
      List jsonCart = json['cart'] as List;
      for (int i = 0; i < jsonCart.length; i++) {
        cart.add(ProductModel.fromJson(jsonCart[i]));
      }
    }
    return UserModel(
      name: json["name"],
      phone: json["phone"],
      dateOfBirth: json["date_of_birth"] ?? "Не выбрано",
      sex: json["sex"],
      street: json["street"] ?? "",
      apartment: json["apartment"] ?? "",
      entrance: json["entrance"] ?? "",
      floor: json["floor"] ?? "",
      orders: orders,
      cart: cart,
    );
  }
}

class OrderModel {
  OrderModel({
    required this.date,
    required this.adress,
    required this.total,
    required this.status,
    required this.id,
    required this.delivery,
    required this.products,
  });

  final String date;
  final String adress;
  final int total;
  final String status;
  final int id;
  final int delivery;
  final List<ProductModel> products;

  factory OrderModel.fromJson(Map<dynamic, dynamic> json, int timestamp) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    return OrderModel(
      date: "${dateTime.day}.${dateTime.month}.${dateTime.year}",
      adress: json['adress'],
      total: json['total'],
      status: json['status'],
      id: timestamp,
      delivery: json['delivery'],
      products: json['products'] == null
          ? []
          : (json['products'] as List<dynamic>)
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList(),
    );
  }
}
