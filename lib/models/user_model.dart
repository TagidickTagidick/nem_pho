class UserModel {
  UserModel({
    required this.name,
    required this.phone,
    required this.dateOfBirth,
    required this.sex,
    required this.street,
    required this.apartment,
    required this.entrance,
    required this.floor,
  });

  final String name;
  final String phone;
  final String dateOfBirth;
  final bool? sex;
  final String street;
  final String apartment;
  final String entrance;
  final String floor;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      name: json["name"],
      phone: json["phone"],
      dateOfBirth: json["date_of_birth"] ?? "Не выбрано",
      sex: json["sex"],
      street: json["street"] ?? "",
      apartment: json["apartment"] ?? "",
      entrance: json["entrance"] ?? "",
      floor: json["floor"] ?? "",
    );
  }
}
