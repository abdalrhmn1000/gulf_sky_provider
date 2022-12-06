// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryModel _$InventoryModelFromJson(Map json) => InventoryModel(
      id: json['id'] as int,
      name: json['item_name'] as String?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'] as String?,
      quantity: json['quantity'] as int?,
      brandName: json['brand_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
