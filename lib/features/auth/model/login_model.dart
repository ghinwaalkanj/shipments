class LoginResponseModel {
  final bool status;
  final String message;
  final int verificationCode;

  LoginResponseModel({
    required this.status,
    required this.message,
    required this.verificationCode,
  });

  factory LoginResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      message: json['message'],
      verificationCode: json['data']['verification_code'],
    );
  }
}
