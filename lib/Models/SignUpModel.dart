class SignUpModel {
  final bool? success;
  final String? message;
  final String? error;
  final User? user;

  SignUpModel({
    this.success,
    this.message,
    this.error,
    this.user,
  });

  SignUpModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        error = json['error'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'error': error,
        'user': user?.toJson()
      };
}

class User {
  final String? id;
  final dynamic name;
  final String? email;
  final dynamic password;
  final dynamic emailVerified;
  final dynamic image;
  final String? createdAt;
  final String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.emailVerified,
    this.image,
    this.createdAt,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'],
        email = json['email'] as String?,
        password = json['password'],
        emailVerified = json['emailVerified'],
        image = json['image'],
        createdAt = json['createdAt'] as String?,
        role = json['role'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'emailVerified': emailVerified,
        'image': image,
        'createdAt': createdAt,
        'role': role
      };
}
