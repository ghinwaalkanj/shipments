class PersonalInfoResponseModel {
  final bool status;
  final String message;

  PersonalInfoResponseModel({
    required this.status,
    required this.message,
  });

  factory PersonalInfoResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return PersonalInfoResponseModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
