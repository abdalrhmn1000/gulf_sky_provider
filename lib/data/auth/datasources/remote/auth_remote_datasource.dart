import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:gulf_sky_provider/data/auth/models/user_model/user_model.dart';
import 'package:gulf_sky_provider/data/core/models/base_response/base_response.dart';
import 'package:gulf_sky_provider/data/core/utils/configuration.dart';
import 'package:http_parser/http_parser.dart';

part 'auth_remote_datasource.g.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<UserModel>> login({
    required String email,
    required String password,
  });



  Future<BaseResponse<UserModel>> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    String? gender,
    required String password,
    File? profileImage,
    String? dateOfBirth,
  });

}

@LazySingleton(as: AuthRemoteDataSource)
@RestApi(baseUrl: '')
abstract class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSourceImpl(Dio dio, Configuration configuration) {
    return _AuthRemoteDataSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @override
  @POST('/public/api/auth/login')
  @FormUrlEncoded()
  Future<BaseResponse<UserModel>> login({
    @Part() required String email,
    @Part() required String password,
  });



  @override
  @POST('/api/auth/register')
  @FormUrlEncoded()
  Future<BaseResponse<UserModel>> signUp({
    @Part() required String email,
    @Part(name: 'first_name') required String firstName,
    @Part(name: 'last_name') required String lastName,
    @Part() required String phone,
    @Part() String? gender,
    @Part() required String password,
    @Part(name: 'profileImage', contentType: 'application/jpg')
        File? profileImage,
    @Part(name: 'date_of_birth') String? dateOfBirth,
  });


}
