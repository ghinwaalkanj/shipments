class IDUploadResponseModel {
  final bool status;
  final String? error;

  IDUploadResponseModel({
    required this.status,
    this.error,
  });

  factory IDUploadResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return IDUploadResponseModel(
      status: json['status'],
      error: json['error'],
    );
  }
}