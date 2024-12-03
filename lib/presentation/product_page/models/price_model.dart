class PriceModel {
  PriceModel({
    required this.id,
    required this.amount,
  });

  final String id;
  final int amount;

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
        id: json['id'],
        amount: json['amount'],
    );
  }
}