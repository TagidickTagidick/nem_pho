class BannerModel {
  final int id;
  final String url;

  BannerModel({
    required this.id,
    required this.url
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
        id: json['id'],
        url: json['url']
    );
  }
}