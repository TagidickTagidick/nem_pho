enum ErrorType {
  none, timeout
}

class ErrorModel {
  final int statusCode;
  final String message;
  final ErrorType errorType;

  ErrorModel({
    this.statusCode = 200,
    this.message = 'Что-то пошло не так',
    this.errorType = ErrorType.none
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        statusCode: json['statusCode'],
        message: json['message']
    );
  }
}