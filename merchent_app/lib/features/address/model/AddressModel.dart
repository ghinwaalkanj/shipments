class Address {
  final int id;
  final int addressUserId;
  final String addressDetails;
  final int addressCity;
  final String addressLat;
  final String addressLong;
  final int isDefault;
  final String createdAt;
  final String updatedAt;
  final String cityName;

  Address({
    required this.id,
    required this.addressUserId,
    required this.addressDetails,
    required this.addressCity,
    required this.addressLat,
    required this.addressLong,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.cityName,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      addressUserId: json['address_user_id'],
      addressDetails: json['address_details'],
      addressCity: json['address_city'],
      addressLat: json['address_lat'],
      addressLong: json['address_long'],
      isDefault: json['is_default'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cityName: json['city_name'],
    );
  }
}
