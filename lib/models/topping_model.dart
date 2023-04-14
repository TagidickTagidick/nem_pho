class ToppingModel {
  ToppingModel({
    required this.title,
    required this.image,
    required this.price
  });

  final String title;
  final String image;
  final String price;

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
        title: json["title"] ?? "",
        image: json["image"] ?? "",
        price: json["price"].toString() ?? ""
    );
  }
}