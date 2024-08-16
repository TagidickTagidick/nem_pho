enum ErrorType {
  none, timeout
}

class ErrorModel {
  final int statusCode;
  final String message;
  final ErrorType errorType;

  ErrorModel({
    required this.statusCode,
    required this.message,
    this.errorType = ErrorType.none
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        statusCode: json['statusCode'],
        message: json['message']
    );
  }
}