import 'package:nem_pho/models/product_model.dart';

class CategoryModel {
  final String text;
  final String image;
  final List<String> banners;
  final List<ProductModel> products;

  CategoryModel({
    required this.text,
    required this.image,
    required this.banners,
    required this.products
});
}