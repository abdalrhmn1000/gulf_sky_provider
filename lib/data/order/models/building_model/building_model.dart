import 'package:gulf_sky_provider/domain/order/entities/building.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@JsonSerializable()
class BuildingModel {
  final int id;
  @JsonKey(name: 'building_name')
  final String? name;
  final String? location;

  @JsonKey(name: 'number_of_building')
  final String? numberOfBuilding;

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  BuildingModel({
    required this.id,
    this.name,
    this.location,
    this.numberOfBuilding,
  });
}

extension MapToDomain on BuildingModel {
  Building toDomain() => Building(
        id: id,
        name: name,
        location:location,
        numberOfBuilding: numberOfBuilding,
      );
}
