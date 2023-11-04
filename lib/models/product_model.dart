class ProductModel {
  ProductModel({
    required this.title,
    required this.text,
    required this.image,
    required this.price,
    required this.isActive,
    required this.compound,
    required this.gramm,
    required this.price2,
  });

  final String title;
  final String text;
  final String image;
  final String price;
  final bool isActive;
  final String compound;
  final List<int> gramm;
  final String? price2;

  factory ProductModel.fromJson(Map json) {
    List<int> gramm = [];
    if (json["gramm"] != null) {
      List jsonGram = json['gramm'] as List;
      for (int i = 0; i < jsonGram.length; i++) {
        gramm.add(jsonGram[i]);
      }
    }
    return ProductModel(
      title: json["title"] ?? "",
      text: json["text"] ?? "",
      image: json["image"] ?? "",
      price: json["price"].toString(),
      isActive: json["is_active"] == 1 ? true : false,
      compound: json["compound"] ?? "",
      gramm: gramm,
      price2: json['price2'] == null ? null : json['price2']!.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'text': text,
        'image': image,
        'price': price,
      };
}
