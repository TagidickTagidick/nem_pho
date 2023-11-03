class ProductModel {
  ProductModel(
      {required this.title,
      required this.text,
      required this.image,
      required this.price,
      required this.isActive,
      required this.gramm,
      required this.compound});

  final String title;
  final String text;
  final String image;
  final String price;
  final bool isActive;
  final List gramm;
  final String compound;

  factory ProductModel.fromJson(Map json) {
    return ProductModel(
      title: json["title"] ?? "",
      text: json["text"] ?? "",
      image: json["image"] ?? "",
      price: json["price"].toString(),
      isActive: json["is_active"] == 1 ? true : false,
      gramm: [],
      compound: json["compound"] ?? "",
    );
  }
}
