class LogInModel {
  final bool? success;
  final String? message;
  final String? token;
  final String? name;
  final String? error;
  final String? userId;

  LogInModel(
      {this.success,
      this.message,
      this.token,
      this.name,
      this.error,
      this.userId});

  LogInModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        token = json['token'] as String?,
        name = json['name'] as String?,
        userId = json['userId'] as String?,
        error = json['error'] as String?;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'token': token,
        'name': name,
        'error': error,
        'userId': userId
      };
}
