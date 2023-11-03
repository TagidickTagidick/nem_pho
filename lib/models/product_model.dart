class ProductModel {
  ProductModel(
      {required this.title,
      required this.text,
      required this.image,
      required this.price,
      required this.isActive,
      required this.compound});

  final String title;
  final String text;
  final String image;
  final String price;
  final bool isActive;
  final String compound;

  factory ProductModel.fromJson(Map json) {
    return ProductModel(
      title: json["title"] ?? "",
      text: json["text"] ?? "",
      image: json["image"] ?? "",
      price: json["price"].toString(),
      isActive: json["is_active"] == 1 ? true : false,
      compound: json["compound"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'text': text,
        'image': image,
        'price': price,
      };
}
