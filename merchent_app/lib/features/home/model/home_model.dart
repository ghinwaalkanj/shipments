class HomeResponseModel {
  bool status;
  List<Ad> ads;
  List<Shipment> shipments;
  String cityName;
  String addressDetails;
  String addressLat;
  String addressLong;

  HomeResponseModel({
    required this.status,
    required this.ads,
    required this.shipments,
    required this.cityName,
    required this.addressDetails,
    required this.addressLat,
    required this.addressLong,
  });

  factory HomeResponseModel.fromJson(Map<dynamic, dynamic> json) {
    var adsList = json['ads'] as List;
    List<Ad> ads = adsList.map((i) => Ad.fromJson(i)).toList();

    var shipmentsList = json['shipments'] as List;
    List<Shipment> shipments = shipmentsList.map((i) => Shipment.fromJson(i)).toList();

    String cityName = json['default_address'] != null ? json['default_address']['city_name'] : '';
    String addressDetails = json['default_address'] != null ? json['default_address']['address_details'] : '';
    String addressLat = json['default_address'] != null ? json['default_address']['address_lat'] : '';
    String addressLong = json['default_address'] != null ? json['default_address']['address_long'] : '';

    return HomeResponseModel(
      status: json['status'],
      ads: ads,
      shipments: shipments,
      cityName: cityName,
      addressDetails: addressDetails,
      addressLat: addressLat,
      addressLong: addressLong,
    );
  }
}

class Ad {
  int? id;
  String? title;
  String? description;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Ad({this.id, this.title, this.description, this.imageUrl, this.createdAt, this.updatedAt});

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Shipment {
  int? shipmentId;
  int? userId;
  String? recipientName;
  String? recipientPhone;
  String? recipientAddress;
  String ?recipientCity;
  String? recipientLat;
  String? recipientLong;
  int? shipmentStatus;
  String? shipmentType;
  String? shipmentWeight;
  int? shipmentQuantity;
  String? shipmentValue;
  String? shipmentFee;
  String? shipmentNote;
  String? shipmentContents;
  String? shipmentNumber;
  int? deliveryUserId;
  String? acceptedAt;
  String? shipmentCreatedAt;
  String? shipmentUpdatedAt;
  String? userName;
  String? userBusinessName;
  String? fromAddressDetails;
  String? fromAddressLat;
  String? fromAddressLong;
  String? fromCityName;
  String? deliveryUserName;
  String? deliveryUserPhone;
  String? averageRating;
  String? estimatedDeliveryTime;

  Shipment({
    this.shipmentId,
    this.userId,
    this.recipientName,
    this.recipientPhone,
    this.recipientAddress,
    this.recipientLat,
    this.recipientLong,
    this.shipmentStatus,
    this.shipmentType,
    this.shipmentWeight,
    this.shipmentQuantity,
    this.shipmentValue,
    this.shipmentFee,
    this.shipmentNote,
    this.shipmentContents,
    this.shipmentNumber,
    this.deliveryUserId,
    this.acceptedAt,
    this.shipmentCreatedAt,
    this.shipmentUpdatedAt,
    this.userName,
    this.userBusinessName,
    this.fromAddressDetails,
    this.fromAddressLat,
    this.fromAddressLong,
    this.fromCityName,
    this.deliveryUserName,
    this.deliveryUserPhone,
    this.averageRating,
    this.estimatedDeliveryTime,
    this.recipientCity,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      shipmentId: json['shipment_id'],
      userId: json['user_id'],
      recipientName: json['recipient_name'],
      recipientPhone: json['recipient_phone'],
      recipientAddress: json['recipient_address'],
      recipientCity: json['recipient_city'
          ''
          ''],
      recipientLat: json['recipient_lat'],
      recipientLong: json['recipient_long'],
      shipmentStatus: json['shipment_status'],
      shipmentType: json['shipment_type'],
      shipmentWeight: json['shipment_weight'],
      shipmentQuantity: json['shipment_quantity'],
      shipmentValue: json['shipment_value'],
      shipmentFee: json['shipment_fee'],
      shipmentNote: json['shipment_note'],
      shipmentContents: json['shipment_contents'],
      shipmentNumber: json['shipment_number'],
      deliveryUserId: json['delivery_user_id'],
      acceptedAt: json['accepted_at'],
      shipmentCreatedAt: json['shipment_created_at'],
      shipmentUpdatedAt: json['shipment_updated_at'],
      userName: json['user_name'],
      userBusinessName: json['user_business_name'],
      fromAddressDetails: json['from_address_details'],
      fromAddressLat: json['from_address_lat'],
      fromAddressLong: json['from_address_long'],
      fromCityName: json['from_city_name'],
      deliveryUserName: json['delivery_user_name'],
      deliveryUserPhone: json['delivery_user_phone'],
      averageRating: json['average_rating'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
    );
  }
}
