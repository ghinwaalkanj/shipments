class VerifyResponseModel {
  final bool status;
  final String token;
  final int userId;

  VerifyResponseModel({
    required this.status,
    required this.token,
    required this.userId,
  });

  factory VerifyResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return VerifyResponseModel(
      status: json['status'],
      token: json['token'],
      userId: json['user_id'],
    );
  }
}
