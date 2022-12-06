// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_pagination_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BasePaginationParamsModelToJson(
    BasePaginationParamsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('limit', instance.limit);
  writeNotNull('skip', instance.skip);
  return val;
}
