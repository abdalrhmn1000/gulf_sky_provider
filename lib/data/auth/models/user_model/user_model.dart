import 'package:json_annotation/json_annotation.dart';
import 'package:gulf_sky_provider/data/user/models/user_info_model/user_info_model.dart';
import 'package:gulf_sky_provider/domain/auth/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: true)
class UserModel {
  @JsonKey(name: 'token')
  final String accessToken;
  @JsonKey(name: 'user')
  final UserInfoModel userInfo;

  UserModel(
    this.accessToken,
    this.userInfo,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith(String token) {
    return UserModel(
      token,
      userInfo,
    );
  }
}

extension MapToDomain on UserModel {
  User toDomain() => User(
        token: accessToken,
        userInfo: userInfo.toDomain(),
      );
}
