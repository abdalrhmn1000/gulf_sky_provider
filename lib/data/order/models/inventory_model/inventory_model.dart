import 'package:gulf_sky_provider/domain/order/entities/inventory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_model.g.dart';

@JsonSerializable()
class InventoryModel {
  final int id;
  @JsonKey(name: 'item_name')
  final String? name;
  final double? price;
  @JsonKey(name: 'original_price')
  final double? originalPrice;
  final String? image;
  final int? quantity;
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryModelFromJson(json);

  InventoryModel({
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

extension MapToDomain on InventoryModel {
  Inventory toDomain() => Inventory(
        id: id,
        name: name,
        originalPrice: originalPrice,
        price: price,
        image: image,
        quantity: quantity,
        brandName: brandName,
        createdAt: createdAt,
      );
}
