class EditProfileResponseModel {
  final bool status;
  final String message;

  EditProfileResponseModel({
    required this.status,
    required this.message,
  });

  factory EditProfileResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return EditProfileResponseModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
