class BuildProfileModel {
  final bool? success;
  final String? message;
  final Profile? profile;

  BuildProfileModel({
    this.success,
    this.message,
    this.profile,
  });

  BuildProfileModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        profile = (json['profile'] as Map<String, dynamic>?) != null
            ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'success': success, 'message': message, 'profile': profile?.toJson()};
}

class Profile {
  final int? id;
  final String? userId;
  final dynamic phone;
  final dynamic clusterLabel;
  final String? salary;
  final int? workExperience;
  final int? age;
  final int? goalRetirementAge;
  final String? safetyInRetirement;
  final String? typeOfRetirement;
  final String? createdAt;
  final String? updatedAt;

  Profile({
    this.id,
    this.userId,
    this.phone,
    this.clusterLabel,
    this.salary,
    this.workExperience,
    this.age,
    this.goalRetirementAge,
    this.safetyInRetirement,
    this.typeOfRetirement,
    this.createdAt,
    this.updatedAt,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['userId'] as String?,
        phone = json['phone'],
        clusterLabel = json['clusterLabel'],
        salary = json['salary'] as String?,
        workExperience = json['workExperience'] as int?,
        age = json['age'] as int?,
        goalRetirementAge = json['goalRetirementAge'] as int?,
        safetyInRetirement = json['safetyInRetirement'] as String?,
        typeOfRetirement = json['typeOfRetirement'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'phone': phone,
        'clusterLabel': clusterLabel,
        'salary': salary,
        'workExperience': workExperience,
        'age': age,
        'goalRetirementAge': goalRetirementAge,
        'safetyInRetirement': safetyInRetirement,
        'typeOfRetirement': typeOfRetirement,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}
