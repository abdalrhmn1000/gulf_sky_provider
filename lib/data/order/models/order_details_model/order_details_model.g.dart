// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsModel _$OrderDetailsModelFromJson(Map json) => OrderDetailsModel(
      id: json['id'] as int,
      ordersId: json['orders_id'] as int?,
      servicesId: json['services_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      duration: json['duration'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      image: json['image'] as String?,
    );
