class Order {
  final int id;
  final String? name;
  final String? orderNumber;
  final String? date;
  final String? time;
  final String? address;
  final String? phone;
  final double? totalPrice;
  final String? notes;
  final String? taxNumber;
  final String? priority;
  final String? status;

  Order({
    required this.id,
    this.name,
    this.orderNumber,
    this.date,
    this.time,
    this.address,
    this.phone,
    this.totalPrice,
    this.notes,
    this.taxNumber,
    this.priority,
    this.status,
  });
}
