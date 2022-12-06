import 'package:json_annotation/json_annotation.dart';
import 'package:gulf_sky_provider/domain/user/entities/enums/gender.dart';

enum GenderModel {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
}

extension ParseToString on GenderModel {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension MapToDomain on GenderModel {
  Gender toDomain() => Gender.values.firstWhere(
        (element) => element.toShortString() == toShortString(),
      );
}

GenderModel? fileGenderModelFromDomain(Gender? type) {
  if (type == null) return null;
  return GenderModel.values.firstWhere((element) => element.name == type.name);
}
String? genderModelFromDomainString(Gender? type) {
  if (type == null) return null;
  switch (GenderModel.values
      .firstWhere((element) => element.name == type.name)) {
    case GenderModel.male:
      return 'Mr.';
    case GenderModel.female:
      return 'Mrs.';
  }
}
