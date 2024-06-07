class ProfileResponseModel {
  final bool status;
  final MerchantInfo merchantInfo;

  ProfileResponseModel({
    required this.status,
    required this.merchantInfo,
  });

  factory ProfileResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return ProfileResponseModel(
      status: json['status'],
      merchantInfo: MerchantInfo.fromJson(json['merchant_info']),
    );
  }
}

class MerchantInfo {
  final int id;
  final String phone;
  final String verificationCode;
  final String name;
  final String nationalId;
  final String businessName;
  final String gender;
  final String? idFrontImage;
  final String? idBackImage;
  final String role;
  final int online;
  final String createdAt;
  final String updatedAt;

  MerchantInfo({
    required this.id,
    required this.phone,
    required this.verificationCode,
    required this.name,
    required this.nationalId,
    required this.businessName,
    required this.gender,
    this.idFrontImage,
    this.idBackImage,
    required this.role,
    required this.online,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MerchantInfo.fromJson(Map<dynamic, dynamic> json) {
    return MerchantInfo(
      id: json['id'],
      phone: json['phone'],
      verificationCode: json['verification_code'],
      name: json['name'],
      nationalId: json['national_id'],
      businessName: json['business_name'],
      gender: json['gender'],
      idFrontImage: json['id_front_image'],
      idBackImage: json['id_back_image'],
      role: json['role'],
      online: json['online'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  factory MerchantInfo.empty() {
    return MerchantInfo(
      id: 0,
      phone: '',
      verificationCode: '',
      name: '',
      nationalId: '',
      businessName: '',
      gender: '',
      idFrontImage: null,
      idBackImage: null,
      role: '',
      online: 0,
      createdAt: '',
      updatedAt: '',
    );
  }
}

