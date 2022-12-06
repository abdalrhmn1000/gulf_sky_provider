class Service {
  final int id;
  final String? name;
  final String? description;
  final double? price;
  final double? totalPrice;
  final String? idCategory;
  final double? rate;
  final String? status;
  final DateTime? createdAt;

  Service({
    required this.id,
    this.name,
    this.description,
    this.price,
    this.totalPrice,
    this.idCategory,
    this.rate,
    this.status,
    this.createdAt,
  });
}
