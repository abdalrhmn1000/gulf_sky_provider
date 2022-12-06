// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map json) => UserInfoModel(
      id: json['id'] as int,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      gender: $enumDecodeNullable(_$GenderModelEnumMap, json['gender']),
      email: json['email'] as String?,
      profileImage: json['profile_image'] as String?,
      dateOfBirth: mapDateTimeFromJson(json['date_of_birth']),
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('gender', _$GenderModelEnumMap[instance.gender]);
  writeNotNull('email', instance.email);
  writeNotNull('profile_image', instance.profileImage);
  writeNotNull('date_of_birth', instance.dateOfBirth?.toIso8601String());
  return val;
}

const _$GenderModelEnumMap = {
  GenderModel.male: 'male',
  GenderModel.female: 'female',
};
