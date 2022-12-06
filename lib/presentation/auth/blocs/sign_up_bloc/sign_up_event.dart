part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpRequested extends SignUpEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final Gender? gender;
  final String password;
  final File? profileImage;
  final DateTime? dateOfBirth;

  SignUpRequested({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.gender,
    required this.password,
    this.profileImage,
    this.dateOfBirth,
  });
}
