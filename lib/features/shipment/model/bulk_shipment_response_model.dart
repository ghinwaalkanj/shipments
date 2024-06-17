class ResponseModel {
  bool status;
  String message;
  int shipmentFee;
  String shipmentNumber;
  String shipmentId;
  ShipmentInfo shipmentInfo;
  UserInfo userInfo;
  RecipientInfo recipientInfo;
  List<dynamic> notifications;

  ResponseModel({
    required this.status,
    required this.message,
    required this.shipmentFee,
    required this.shipmentNumber,
    required this.shipmentId,
    required this.shipmentInfo,
    required this.userInfo,
    required this.recipientInfo,
    required this.notifications,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      shipmentFee: json['shipment_fee'],
      shipmentNumber: json['shipment_number'],
      shipmentId: json['shipment_id'],
      shipmentInfo: ShipmentInfo.fromJson(json['shipment_info']),
      userInfo: UserInfo.fromJson(json['user_info']),
      recipientInfo: RecipientInfo.fromJson(json['recipient_info']),
      notifications: json['notifications'],
    );
  }
}

class ShipmentInfo {
  int shipmentUserId;
  int shipmentStatus;
  String shipmentType;
  int shipmentWeight;
  int shipmentQuantity;
  String shipmentValue;
  int shipmentFee;
  String shipmentNote;
  String shipmentContents;
  String shipmentNumber;
  int merchantAddressId;

  ShipmentInfo({
    required this.shipmentUserId,
    required this.shipmentStatus,
    required this.shipmentType,
    required this.shipmentWeight,
    required this.shipmentQuantity,
    required this.shipmentValue,
    required this.shipmentFee,
    required this.shipmentNote,
    required this.shipmentContents,
    required this.shipmentNumber,
    required this.merchantAddressId,
  });

  factory ShipmentInfo.fromJson(Map<String, dynamic> json) {
    return ShipmentInfo(
      shipmentUserId: json['shipment_user_id'],
      shipmentStatus: json['shipment_status'],
      shipmentType: json['shipment_type'],
      shipmentWeight: json['shipment_weight'],
      shipmentQuantity: json['shipment_quantity'],
      shipmentValue: json['shipment_value'],
      shipmentFee: json['shipment_fee'],
      shipmentNote: json['shipment_note'],
      shipmentContents: json['shipment_contents'],
      shipmentNumber: json['shipment_number'],
      merchantAddressId: json['merchant_address_id'],
    );
  }
}

class UserInfo {
  int id;
  String phone;
  String verificationCode;
  String name;
  String nationalId;
  String businessName;
  String gender;
  String idFrontImage;
  String? idBackImage;
  String role;
  int online;
  String createdAt;
  String updatedAt;
  String city;

  UserInfo({
    required this.id,
    required this.phone,
    required this.verificationCode,
    required this.name,
    required this.nationalId,
    required this.businessName,
    required this.gender,
    required this.idFrontImage,
    this.idBackImage,
    required this.role,
    required this.online,
    required this.createdAt,
    required this.updatedAt,
    required this.city,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
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
      city: json['city'],
    );
  }
}

class RecipientInfo {
  String name;
  String phone;
  String address;
  String lat;
  String long;
  String city;

  RecipientInfo({
    required this.name,
    required this.phone,
    required this.address,
    required this.lat,
    required this.long,
    required this.city,
  });

  factory RecipientInfo.fromJson(Map<String, dynamic> json) {
    return RecipientInfo(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      lat: json['lat'],
      long: json['long'],
      city: json['city'],
    );
  }
}
