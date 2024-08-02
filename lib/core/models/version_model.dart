class VersionModel {
  final String version;
  final bool isUpdate;

  VersionModel({
    required this.version,
    required this.isUpdate
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
        version: json['version'],
        isUpdate: json['is_update']
    );
  }
}