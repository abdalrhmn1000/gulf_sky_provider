import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:json_annotation/json_annotation.dart';


part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  final int id;
  final String? name;
  final String? description;
  final double? price;
  @JsonKey(name: 'total_price')
  final double? totalPrice;
  @JsonKey(name: 'idcategory')
  final String? idCategory;
  final double? rate;
  final String? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  ServiceModel({
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

extension MapToDomain on ServiceModel {
  Service toDomain() => Service(
        id: id,
        name: name,
        description: description,
        price: price,
        totalPrice: totalPrice,
        idCategory: idCategory,
        rate: rate,
        status: status,
        createdAt: createdAt,
      );
}
