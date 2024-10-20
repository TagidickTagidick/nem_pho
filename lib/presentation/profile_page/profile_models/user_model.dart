class UserModel {
  final String phone;

  UserModel({
    required this.phone
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        phone: json['json']
    );
  }

  static UserModel mock = UserModel(phone: 'Горячая дойка');
}