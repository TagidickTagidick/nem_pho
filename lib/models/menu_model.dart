// class MenuModel {
//   MenuModel({
//     required this.title,
//     required this.image
//   });
//
//   final String title;
//   final String image;
//   final List<MenuItemModel> menuItems;
//
//   factory MenuModel.fromJson(Map<String, dynamic> json) {
//     List<MenuItemModel> list = [];
//     if (json["trainings"] != null) {
//       json["trainings"].forEach((k, v) => list.add(TrainingModel.fromJson(k, v)));
//     }
//     return MenuModel(
//         title: json["title"] ?? "",
//         image: json["image"] ?? "",
//         menuItems:
//     );
//   }
// }

class ProductModel {
  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        title: json["title"] ?? "",
        text: json["text"] ?? "",
        image: json["image"] ?? "",
        price: json["price"].toString() ?? "",
        isActive: json["is_active"] == 1
            ? true
            : false,
        gramm: []
    );
  }
}