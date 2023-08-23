class ToppingModel {
  ToppingModel({
    required this.title,
    required this.image,
    required this.price,
    required this.gramm
  });

  final String title;
  final String image;
  final String price;
  final String gramm;

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
        title: json["title"] ?? "",
        image: json["image"] ?? "",
        price: json["price"].toString() ?? "",
        gramm: json["gramm"] ?? "",
    );
  }
}