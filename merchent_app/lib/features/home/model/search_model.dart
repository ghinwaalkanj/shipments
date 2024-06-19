class Shipment {
  final int shipmentId;
  final int shipmentUserId;
  final int shipmentStatus;
  final String shipmentType;
  final String shipmentWeight;
  final int shipmentQuantity;
  final String shipmentValue;
  final String shipmentFee;
  final String shipmentNote;
  final String shipmentContents;
  final String shipmentNumber;

  Shipment( {
    required this.shipmentId,
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
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      shipmentId:json['id'],
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
    );
  }
}

class UserInfo {
  final int id;
  final String phone;
  final String verificationCode;
  final String name;
  final String nationalId;
  final String businessName;
  final String gender;
  final String idFrontImage;
  final String idBackImage;
  final String role;
  final int online;
  final String createdAt;
  final String updatedAt;
  final String city;

  UserInfo({
    required this.id,
    required this.phone,
    required this.verificationCode,
    required this.name,
    required this.nationalId,
    required this.businessName,
    required this.gender,
    required this.idFrontImage,
    required this.idBackImage,
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
  final String name;
  final String phone;
  final String address;
  final String lat;
  final String long;
  final String city;

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

class SearchResult {
  final Shipment shipmentInfo;
  final UserInfo userInfo;
  final RecipientInfo recipientInfo;

  SearchResult({
    required this.shipmentInfo,
    required this.userInfo,
    required this.recipientInfo,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      shipmentInfo: Shipment.fromJson(json['shipment_info']),
      userInfo: UserInfo.fromJson(json['user_info']),
      recipientInfo: RecipientInfo.fromJson(json['recipient_info']),
    );
  }
}
