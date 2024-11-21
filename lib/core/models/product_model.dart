import 'package:nem_pho/presentation/product_page/models/topping_model.dart';

class ProductModel {
  final int id;
  final int price;
  final String image;
  final String title;
  final String description;
  final String? composition;
  final List<ToppingModel> toppings;

  ProductModel({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    this.composition,
    required this.toppings,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      composition: json['composition'],
      toppings: json['toppings'] == null
          ? []
          : List<ToppingModel>.from(
              json['toppings'].map(
                (x) => ToppingModel.fromJson(x),
              ),
            ),
    );
  }

  static List<ProductModel> listFromJson(Map<String, dynamic> json) {
    List<ProductModel> products = [];
    for (var product in json['payload']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  static ProductModel mock = ProductModel(
    id: 1,
    image: 'https://firebasestorage.googleapis.com/v0/b/nem-pho-f7f'
        '90.appspot.com/o/%D0%94%D0%BE%D1'
        '%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B0.png?alt='
        'media&token=9e650e28-0682-4cc4-afc0-087bebf6ef80&_gl=1*1'
        'i33b7i*_ga*MTAwMzY3MTc3MS4xNjkyMjEzMzUx*_ga_CW55HF8NVT*MTY5ODQ4Njc2NS4xMy4xLjE2OT'
        'g0ODY4MDMuMjIuMC4w',
    title: 'ФО БО',
    description: 'ФУ бо',
    price: 500,
    toppings: [],
  );
}
