import 'package:gulf_sky_provider/domain/user/entities/enums/gender.dart';

class UserInfo {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? phone;
  final Gender? gender;
  final String? email;
  final String? profileImage;
  final DateTime? dateOfBirth;

  UserInfo({
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

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  UserInfo copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    Gender? gender,
    DateTime? dateOfBirth,
    String? profileImage,
  }) {
    return UserInfo(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
