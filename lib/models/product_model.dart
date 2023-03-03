import 'package:nem_pho/models/topping_model.dart';

class ProductModel {
  final String id;
  final String title;
  final String text;
  final String image;
  final String? badge;
  final String ml;
  final int price;
  final List<ToppingModel> toppings;

  ProductModel({
    required this.id,
    required this.title,
    required this.text,
    required this.image,
    required this.badge,
    required this.ml,
    required this.price,
    required this.toppings
});
}