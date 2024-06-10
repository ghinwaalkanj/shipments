class VerifyResponseModel {
  final bool status;
  final String token;
  final int userId;
  final String? name;
  final String? nationalId;
  final String? businessName;
  final String? gender;

  VerifyResponseModel({
    required this.status,
    required this.token,
    required this.userId,
    this.name,
    this.nationalId,
    this.businessName,
    this.gender,
  });

  factory VerifyResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return VerifyResponseModel(
      status: json['status'],
      token: json['token'],
      userId: json['user_id'],
      name: json['name'],
      nationalId: json['national_id'],
      businessName: json['business_name'],
      gender: json['gender'],
    );
  }
}
