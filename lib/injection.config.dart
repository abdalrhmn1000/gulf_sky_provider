// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:logger/logger.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import 'data/auth/datasources/local/auth_local_datasource.dart' as _i18;
import 'data/auth/datasources/remote/auth_remote_datasource.dart' as _i19;
import 'data/auth/repositories/auth_repository_impl.dart' as _i21;
import 'data/core/models/remote_assets/remote_assets.dart' as _i12;
import 'data/core/utils/configuration.dart' as _i3;
import 'data/core/utils/network/network_info.dart' as _i8;
import 'data/order/datasources/remote/order_remote_datasource.dart' as _i9;
import 'data/order/repositories/order_repository_impl.dart' as _i11;
import 'domain/auth/repositories/auth_repository.dart' as _i20;
import 'domain/auth/usecases/get_first_time_logged_use_case.dart' as _i23;
import 'domain/auth/usecases/get_signed_in_user_use_case.dart' as _i24;
import 'domain/auth/usecases/login_use_case.dart' as _i26;
import 'domain/auth/usecases/logout_use_case.dart' as _i27;
import 'domain/auth/usecases/set_first_time_logged_use_case.dart' as _i31;
import 'domain/auth/usecases/sign_up_use_case.dart' as _i32;
import 'domain/auth/usecases/subscribe_to_auth_status.dart' as _i34;
import 'domain/core/utils/network/network_info.dart' as _i7;
import 'domain/order/repositories/order_repository.dart' as _i10;
import 'domain/order/usecases/create_order_detail_item_use_case.dart' as _i22;
import 'domain/order/usecases/inventory_list_use_case.dart' as _i25;
import 'domain/order/usecases/my_order_list_use_case.dart' as _i28;
import 'domain/order/usecases/order_details_use_case.dart' as _i29;
import 'domain/order/usecases/service_by_id_list_use_case.dart' as _i13;
import 'domain/order/usecases/sub_service_by_id_list_use_case.dart' as _i15;
import 'domain/order/usecases/update_order_details_use_case.dart' as _i16;
import 'domain/order/usecases/update_order_use_case.dart' as _i17;
import 'injectable_module.dart' as _i44;
import 'presentation/auth/blocs/login/login_bloc.dart' as _i40;
import 'presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart' as _i43;
import 'presentation/core/auth/auth_bloc.dart' as _i37;
import 'presentation/order/blocs/create_order_detail_item_bloc/create_order_detail_item_bloc.dart'
    as _i38;
import 'presentation/order/blocs/inventory_list_bloc/inventory_list_bloc.dart'
    as _i39;
import 'presentation/order/blocs/my_order_list_bloc/my_order_list_bloc.dart'
    as _i41;
import 'presentation/order/blocs/order_details_bloc/order_details_bloc.dart'
    as _i42;
import 'presentation/order/blocs/service_by_id_bloc/service_by_id_bloc.dart'
    as _i30;
import 'presentation/order/blocs/sub_service_by_id_bloc/sub_service_by_id_bloc.dart'
    as _i33;
import 'presentation/order/blocs/update_order_bloc/update_order_bloc.dart'
    as _i35;
import 'presentation/order/blocs/update_order_details_bloc/update_order_details_bloc.dart'
    as _i36;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.Configuration>(
    () => _i3.DevConfiguration(),
    registerFor: {_dev},
  );
  gh.lazySingleton<_i3.Configuration>(
    () => _i3.StagingConfiguration(),
    registerFor: {_staging},
  );
  gh.lazySingleton<_i3.Configuration>(
    () => _i3.ProductionConfiguration(),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i4.Dio>(() => injectableModule.dioInstance);
  gh.lazySingleton<_i5.InternetConnectionChecker>(
      () => injectableModule.connectionChecker);
  gh.lazySingleton<_i6.Logger>(() => injectableModule.logger);
  gh.lazySingleton<_i7.NetworkInfo>(
      () => _i8.NetworkInfoImpl(get<_i5.InternetConnectionChecker>()));
  gh.lazySingleton<_i9.OrderRemoteDataSource>(
      () => _i9.OrderRemoteDataSourceImpl(
            get<_i4.Dio>(),
            get<_i3.Configuration>(),
          ));
  gh.lazySingleton<_i10.OrderRepository>(() => _i11.OrderRepositoryImpl(
        get<_i9.OrderRemoteDataSource>(),
        get<_i7.NetworkInfo>(),
        get<_i6.Logger>(),
        get<_i3.Configuration>(),
      ));
  gh.lazySingleton<_i12.RemoteAssets>(
      () => _i12.RemoteAssets(get<_i3.Configuration>()));
  gh.lazySingleton<_i13.ServiceByIdListUseCase>(() =>
      _i13.ServiceByIdListUseCase(repository: get<_i10.OrderRepository>()));
  await gh.lazySingletonAsync<_i14.SharedPreferences>(
    () => injectableModule.sharedPref,
    preResolve: true,
  );
  gh.lazySingleton<_i15.SubServiceByIdListUseCase>(() =>
      _i15.SubServiceByIdListUseCase(repository: get<_i10.OrderRepository>()));
  gh.lazySingleton<_i16.UpdateOrderDetailsUseCase>(() =>
      _i16.UpdateOrderDetailsUseCase(repository: get<_i10.OrderRepository>()));
  gh.lazySingleton<_i17.UpdateOrderUseCase>(
      () => _i17.UpdateOrderUseCase(repository: get<_i10.OrderRepository>()));
  gh.lazySingleton<_i18.AuthLocalDatasource>(
    () => _i18.AuthLocalDatasourceImpl(get<_i14.SharedPreferences>()),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i19.AuthRemoteDataSource>(
      () => _i19.AuthRemoteDataSourceImpl(
            get<_i4.Dio>(),
            get<_i3.Configuration>(),
          ));
  gh.lazySingleton<_i20.AuthRepository>(() => _i21.AuthRepositoryImpl(
        get<_i18.AuthLocalDatasource>(),
        get<_i19.AuthRemoteDataSource>(),
        get<_i7.NetworkInfo>(),
        get<_i6.Logger>(),
        get<_i3.Configuration>(),
      ));
  gh.lazySingleton<_i22.CreateOrderDetailItemUseCase>(() =>
      _i22.CreateOrderDetailItemUseCase(
          repository: get<_i10.OrderRepository>()));
  gh.lazySingleton<_i23.GetFirstTimeLoggedUseCase>(
      () => _i23.GetFirstTimeLoggedUseCase(get<_i20.AuthRepository>()));
  gh.lazySingleton<_i24.GetSignedInUserUseCase>(
      () => _i24.GetSignedInUserUseCase(get<_i20.AuthRepository>()));
  gh.lazySingleton<_i25.InventoryListUseCase>(
      () => _i25.InventoryListUseCase(repository: get<_i10.OrderRepository>()));
  gh.lazySingleton<_i26.LoginUseCase>(
      () => _i26.LoginUseCase(get<_i20.AuthRepository>()));
  gh.lazySingleton<_i27.LogoutUseCase>(
      () => _i27.LogoutUseCase(repository: get<_i20.AuthRepository>()));
  gh.lazySingleton<_i28.MyOrderListUseCase>(
      () => _i28.MyOrderListUseCase(repository: get<_i10.OrderRepository>()));
  gh.lazySingleton<_i29.OrderDetailsUseCase>(
      () => _i29.OrderDetailsUseCase(repository: get<_i10.OrderRepository>()));
  gh.factory<_i30.ServiceByIdListBloc>(
      () => _i30.ServiceByIdListBloc(get<_i13.ServiceByIdListUseCase>()));
  gh.lazySingleton<_i31.SetFirstTimeLoggedUseCase>(
      () => _i31.SetFirstTimeLoggedUseCase(get<_i20.AuthRepository>()));
  gh.lazySingleton<_i32.SignUpUseCase>(
      () => _i32.SignUpUseCase(repository: get<_i20.AuthRepository>()));
  gh.factory<_i33.SubServiceByIdListBloc>(
      () => _i33.SubServiceByIdListBloc(get<_i15.SubServiceByIdListUseCase>()));
  gh.lazySingleton<_i34.SubscribeToAuthStatusUseCase>(
      () => _i34.SubscribeToAuthStatusUseCase(get<_i20.AuthRepository>()));
  gh.factory<_i35.UpdateOrderBloc>(
      () => _i35.UpdateOrderBloc(get<_i17.UpdateOrderUseCase>()));
  gh.factory<_i36.UpdateOrderDetailsBloc>(
      () => _i36.UpdateOrderDetailsBloc(get<_i16.UpdateOrderDetailsUseCase>()));
  gh.factory<_i37.AuthBloc>(() => _i37.AuthBloc(
        get<_i24.GetSignedInUserUseCase>(),
        get<_i27.LogoutUseCase>(),
        get<_i34.SubscribeToAuthStatusUseCase>(),
        get<_i23.GetFirstTimeLoggedUseCase>(),
        get<_i31.SetFirstTimeLoggedUseCase>(),
      ));
  gh.factory<_i38.CreateOrderDetailItemBloc>(() =>
      _i38.CreateOrderDetailItemBloc(get<_i22.CreateOrderDetailItemUseCase>()));
  gh.factory<_i39.InventoryListBloc>(
      () => _i39.InventoryListBloc(get<_i25.InventoryListUseCase>()));
  gh.factory<_i40.LoginBloc>(
      () => _i40.LoginBloc(login: get<_i26.LoginUseCase>()));
  gh.factory<_i41.MyOrderListBloc>(
      () => _i41.MyOrderListBloc(get<_i28.MyOrderListUseCase>()));
  gh.factory<_i42.OrderDetailsListBloc>(
      () => _i42.OrderDetailsListBloc(get<_i29.OrderDetailsUseCase>()));
  gh.factory<_i43.SignUpBloc>(() => _i43.SignUpBloc(get<_i32.SignUpUseCase>()));
  return get;
}

class _$InjectableModule extends _i44.InjectableModule {}
