class ProductModel {
  final int id;
  final String image;
  final String title;
  final String description;
  final int price;
  final String? composition;
  final bool? isTopping;

  ProductModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.composition,
    this.isTopping
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        description: json['description'] ,
        price: json['price'],
        composition: json['composition'],
        isTopping: json['is_topping']
    );
  }

  static List<ProductModel> listFromJson(Map<String, dynamic> json) {
    List<ProductModel> products = [];
    for (var product in json['payload']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }
}