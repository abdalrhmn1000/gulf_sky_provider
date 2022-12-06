class Inventory {
  final int id;
  final String? name;
  final double? price;
  final double? originalPrice;
  final String? image;
  final int? quantity;
  final String? brandName;
  final DateTime? createdAt;

  Inventory({
    required this.id,
    this.name,
    this.originalPrice,
    this.price,
    this.image,
    this.quantity,
    this.brandName,
    this.createdAt,
  });
}
