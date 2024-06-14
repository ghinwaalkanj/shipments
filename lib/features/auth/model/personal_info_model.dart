class PersonalInfoResponseModel {
  final bool status;
  final String? message;
  final String? idFrontImage;
  final String? idBackImage;

  PersonalInfoResponseModel({
    required this.status,
    this.message,
    this.idFrontImage,
    this.idBackImage,
  });

  factory PersonalInfoResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return PersonalInfoResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      idFrontImage: json['id_front_image'],
      idBackImage: json['id_back_image'],
    );
  }
}
