class OrderDetails {
  final int id;
  final int? ordersId;
  final int? servicesId;
  final int? subServiceId;
  final double? price;
  final String? duration;
  final DateTime? createdAt;
  final String? image;

  OrderDetails({
    required this.id,
    this.ordersId,
    this.servicesId,
    this.subServiceId,
    this.price,
    this.duration,
    this.createdAt,
    this.image,
  });
}
