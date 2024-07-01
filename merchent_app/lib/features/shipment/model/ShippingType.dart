class ShippingType {
  final int id;
  final String type;
  final String pricePerKg;
  final String pricePerKm;
  final String estimatedDeliveryTime;
  final String? notes;

  ShippingType({
    required this.id,
    required this.type,
    required this.pricePerKg,
    required this.pricePerKm,
    required this.estimatedDeliveryTime,
    this.notes,
  });

  factory ShippingType.fromJson(Map<String, dynamic> json) {
    return ShippingType(
      id: json['id'],
      type: json['type'],
      pricePerKg: json['price_per_kg'],
      pricePerKm: json['price_per_km'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
      notes: json['notes'],
    );
  }


}