class UserModel {
  final String? phone;
  final String? orderPhone;
  final String? birthday;
  final String? building;
  final int? entrance;
  final int? flat;
  final int? floor;
  final String? name;
  final String? sex;
  final String? street;
  final String? comment;
  final bool? isSelf;
  final bool? isCard;

  UserModel({
    required this.phone,
    required this.orderPhone,
    required this.birthday,
    required this.building,
    required this.entrance,
    required this.flat,
    required this.floor,
    required this.name,
    required this.sex,
    required this.street,
    required this.comment,
    required this.isSelf,
    required this.isCard
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        phone: json['phone'],
        orderPhone: json['order_phone'],
        birthday: json['birthday'],
        building: json['building'],
        entrance: json['entrance'],
        flat: json['flat'],
        floor: json['floor'],
        name: json['name'],
        sex: json['sex'],
        street: json ['street'],
        comment: json['comment'],
        isSelf: json['is_self'],
        isCard: json['is_card']
    );
  }
}