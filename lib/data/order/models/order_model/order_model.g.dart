// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map json) => OrderModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      orderNumber: json['order_number'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      taxNumber: json['tax_number'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      maintenanceCost: (json['maintenance_cost'] as num?)?.toDouble(),
      assignedTo: json['assigned_to'] as int?,
      buildingId: json['building_id'] as int?,
      isDraft: json['is_draft'] as int?,
      isRepeated: json['is_repeated'] as int?,
      isTanent: json['is_real_estate_tanent'] as int?,
      roomNumber: json['room_number'] as String?,
      userId: json['user_id'] as int?,
    );
