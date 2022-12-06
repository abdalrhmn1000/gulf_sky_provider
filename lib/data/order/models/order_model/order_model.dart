import 'package:gulf_sky_provider/domain/order/entities/order.dart';
import 'package:json_annotation/json_annotation.dart';


part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;
  final String? name;
  @JsonKey(name: 'order_number')
  final String? orderNumber;
  final String? date;
  final String? time;
  final String? address;
  final String? phone;
  @JsonKey(name: 'total_price')
  final double? totalPrice;
  final String? notes;
  @JsonKey(name: 'tax_number')
  final String? taxNumber;
  final String? priority;
  final String? status;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  OrderModel({
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

extension MapToDomain on OrderModel {
  Order toDomain() => Order(
        id: id,
        name: name,
        orderNumber: orderNumber,
        date: date,
        time: time,
        address: address,
        phone: phone,
        totalPrice: totalPrice,
        notes: notes,
        taxNumber: taxNumber,
        priority: priority,
        status: status,
      );
}
