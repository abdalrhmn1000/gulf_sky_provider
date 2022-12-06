// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      message: json['message'] as String? ?? '',
      totalRecords: json['totalRecords'] as int?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      code: mapCodeFromJson(json['code']),
    );

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);
