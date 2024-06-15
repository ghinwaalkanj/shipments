class ShipmentResponseModel {
  final bool status;
  final String message;
  final String? shipmentFee;
  final String? shipmentNumber;
  final String? shipmentId; // Add shipmentId
  final ShipmentInfo? shipmentInfo;
  final UserInfo? userInfo;
  final RecipientInfo? recipientInfo;

  ShipmentResponseModel({
    required this.status,
    required this.message,
    this.shipmentFee,
    this.shipmentNumber,
    this.shipmentId, // Add shipmentId to the constructor
    this.shipmentInfo,
    this.userInfo,
    this.recipientInfo,
  });

  factory ShipmentResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return ShipmentResponseModel(
      status: json['status'],
      message: json['message'],
      shipmentFee: json['shipment_fee'],
      shipmentNumber: json['shipment_number'],
      shipmentId: json['shipment_id'], // Parse shipmentId
      shipmentInfo: json['shipment_info'] != null
          ? ShipmentInfo.fromJson(json['shipment_info'])
          : null,
      userInfo: json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null,
      recipientInfo: json['recipient_info'] != null
          ? RecipientInfo.fromJson(json['recipient_info'])
          : null,
    );
  }
}

class ShipmentInfo {
  final String? shipmentUserId;
  final int? shipmentStatus;
  final String? shipmentType;
  final String? shipmentWeight;
  final String? shipmentQuantity;
  final String? shipmentValue;
  final String? shipmentFee;
  final String? shipmentNote;
  final String? shipmentContents;
  final String? shipmentNumber;
  final int? merchantAddressId;

  ShipmentInfo({
    this.shipmentUserId,
    this.shipmentStatus,
    this.shipmentType,
    this.shipmentWeight,
    this.shipmentQuantity,
    this.shipmentValue,
    this.shipmentFee,
    this.shipmentNote,
    this.shipmentContents,
    this.shipmentNumber,
    this.merchantAddressId,
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
  final int? id;
  final String? phone;
  final String? verificationCode;
  final String? name;
  final String? nationalId;
  final String? businessName;
  final String? gender;
  final String? idFrontImage;
  final String? idBackImage;
  final String? role;
  final int? online;
  final String? createdAt;
  final String? updatedAt;

  UserInfo({
    this.id,
    this.phone,
    this.verificationCode,
    this.name,
    this.nationalId,
    this.businessName,
    this.gender,
    this.idFrontImage,
    this.idBackImage,
    this.role,
    this.online,
    this.createdAt,
    this.updatedAt,
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
    );
  }
}

class RecipientInfo {
  final String? name;
  final String? phone;
  final String? address;
  final String? lat;
  final String? long;
  final String? city;

  RecipientInfo({
    this.name,
    this.phone,
    this.address,
    this.lat,
    this.long,
    this.city,
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
