class MenuModel {
  MenuModel({
    required this.title,
    required this.text,
    required this.image,
    required this.price,
    required this.isActive,
    required this.gramm
  });

  final String title;
  final String text;
  final String image;
  final String price;
  final bool isActive;
  final List gramm;

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
        title: json["title"] ?? "",
        text: json["text"] ?? "",
        image: json["image"] ?? "",
      price: json["price"].toString() ?? "",
      isActive: json["is_active"] == 1
          ? true
          : false,
      gramm: json["gramm"] ?? []
    );
  }
}