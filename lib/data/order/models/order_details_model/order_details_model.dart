import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_details_model.g.dart';

@JsonSerializable()
class OrderDetailsModel {
  final int id;
  @JsonKey(name: 'orders_id')
  final int? ordersId;
  @JsonKey(name: 'services_id')
  final int? servicesId;
  @JsonKey(name: 'sub_service_id')
  final int? subServiceId;
  final double? price;
  final String? duration;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String? image;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);

  OrderDetailsModel({
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

extension MapToDomain on OrderDetailsModel {
  OrderDetails toDomain() => OrderDetails(
        id: id,
        ordersId: ordersId,
        servicesId: servicesId,
        subServiceId: subServiceId,
        price: price,
        duration: duration,
        createdAt: createdAt,
        image: image,
      );
}
