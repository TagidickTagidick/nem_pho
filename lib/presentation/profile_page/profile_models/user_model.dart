class UserModel {
  // final String phone;
  final String? birthday;
  final String? building;
  final int? entrance;
  final int? flat;
  final int? floor;
  final String? name;
  final String? sex;
  final String? street;

  UserModel({
    // required this.phone,
    required this.birthday,
    required this.building,
    required this.entrance,
    required this.flat,
    required this.floor,
    required this.name,
    required this.sex,
    required this.street
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // phone: json['json'],
        birthday: json['birthday'],
        building: json['building'],
        entrance: json['entrance'],
        flat: json['flat'],
        floor: json['floor'],
        name: json['name'],
        sex: json['sex'],
        street: json ['street']
    );
  }

// static UserModel mock = UserModel(phone: 'Горячая дойка');
}