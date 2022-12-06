import 'package:json_annotation/json_annotation.dart';
import 'package:gulf_sky_provider/data/user/models/enums/gender_model.dart';
import 'package:gulf_sky_provider/domain/user/entities/user_info.dart';

part 'user_info_model.g.dart';

@JsonSerializable(createToJson: true)
class UserInfoModel {
  final int id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? name;
  final String? phone;
  final GenderModel? gender;
  final String? email;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'date_of_birth', fromJson: mapDateTimeFromJson)
  final DateTime? dateOfBirth;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  UserInfoModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.phone,
    this.gender,
    this.email,
    this.profileImage,
    this.dateOfBirth,
  });

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  UserInfoModel copyWith(
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    GenderModel? gender,
    DateTime? dateOfBirth,
  ) {
    return UserInfoModel(
      id:id,
      firstName:firstName ?? this.firstName,
      lastName:lastName ?? this.lastName,
      name:name,
      phone:phone ?? this.phone,
      gender:gender ?? this.gender,
      email:email ?? this.email,
      profileImage:profileImage,
      dateOfBirth:dateOfBirth ?? this.dateOfBirth,
    );
  }
}

extension MapToDomain on UserInfoModel {
  UserInfo toDomain() => UserInfo(
        id: id,
        firstName: firstName,
        lastName: lastName,
        name: name,
        phone: phone,
        gender: gender?.toDomain(),
        email: email,
        profileImage: profileImage,
        dateOfBirth: dateOfBirth,
      );
}
DateTime? mapDateTimeFromJson(value) {
  if (value is String) return null;

  return value;
}