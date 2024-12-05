class ToppingModel {
  final String id;
  final String image;
  final String title;
  final int price;

  ToppingModel({
    required this.id,
    required this.image,
    required this.title,
    required this.price
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      id: json['id'],
        image: json['image'],
        title: json['title'],
        price: json['price']
    );
  }

  static List<ToppingModel> listFromJson(Map<String, dynamic> json) {
    List<ToppingModel> toppings = [];
    for (var topping in json['payload']) {
      toppings.add(ToppingModel.fromJson(topping));
    }
    return toppings;
  }

  static ToppingModel mock = ToppingModel(
    id: "1",
      image: 'Головяшкина',
      title: 'Говядина',
      price: 5500
  );
}