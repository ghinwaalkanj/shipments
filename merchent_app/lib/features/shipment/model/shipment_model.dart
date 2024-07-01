class ShipmentModel {
  final String userId;
  final String recipientName;
  final String recipientPhone;
  final String recipientAddress;
  final String recipientCity;
  final String recipientLat;
  final String recipientLong;
  final String shipmentType;
  final String shipmentWeight;
  final String shipmentQuantity;
  final String shipmentValue;
  final String shipmentNote;
  final String shipmentContents;
  final String shipmentFee;
  final String shipmentDistance; // إضافة المسافة

  ShipmentModel({
    required this.userId,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientCity,
    required this.recipientAddress,
    required this.recipientLat,
    required this.recipientLong,
    required this.shipmentType,
    required this.shipmentWeight,
    required this.shipmentQuantity,
    required this.shipmentValue,
    required this.shipmentNote,
    required this.shipmentContents,
    required this.shipmentFee,
    required this.shipmentDistance, // إضافة المسافة
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'recipient_name': recipientName,
      'recipient_phone': recipientPhone,
      'recipient_address': recipientAddress,
      'recipient_lat': recipientLat,
      'recipient_long': recipientLong,
      'shipment_type': shipmentType,
      'shipment_weight': shipmentWeight,
      'shipment_quantity': shipmentQuantity,
      'shipment_value': shipmentValue,
      'shipment_note': shipmentNote,
      'shipment_contents': shipmentContents,
      'shipment_fee': shipmentFee,
      'recipient_city': recipientCity,
      'shipment_distance': shipmentDistance, // إضافة المسافة
    };
  }
}
