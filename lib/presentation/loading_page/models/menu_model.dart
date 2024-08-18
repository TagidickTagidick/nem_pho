class MenuModel {
  final int id;
  final String image;
  final String name;

  MenuModel({
    required this.image,
    required this.id,
    required this.name
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
        image: json['image'],
        id: json['id'],
        name: json['name']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name
    };
  }
}