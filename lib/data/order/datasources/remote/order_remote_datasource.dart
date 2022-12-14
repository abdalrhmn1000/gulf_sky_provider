import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gulf_sky_provider/data/core/models/base_response/base_response.dart';
import 'package:gulf_sky_provider/data/core/utils/configuration.dart';
import 'package:gulf_sky_provider/data/order/models/building_model/building_model.dart';
import 'package:gulf_sky_provider/data/order/models/inventory_model/inventory_model.dart';
import 'package:gulf_sky_provider/data/order/models/order_details_model/order_details_model.dart';
import 'package:gulf_sky_provider/data/order/models/order_model/order_model.dart';
import 'package:gulf_sky_provider/data/order/models/service_model/service_model.dart';
import 'package:gulf_sky_provider/data/user/models/user_info_model/user_info_model.dart';
import 'package:http_parser/http_parser.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'order_remote_datasource.g.dart';

abstract class OrderRemoteDataSource {
  Future<BaseResponse<List<OrderModel>>> getMyOrders();

  Future<BaseResponse<List<InventoryModel>>> getInventoryItems();

  Future<BaseResponse<List<BuildingModel>>> getBuildings();

  Future<BaseResponse<List<UserInfoModel>>> getSupervisors();

  Future<BaseResponse<List<OrderDetailsModel>>> getOrderDetails({
    required int orderId,
  });

  Future<BaseResponse<ServiceModel>> getServiceById({
    required int id,
  });

  Future<BaseResponse<ServiceModel>> getSubServiceById({
    required int id,
  });

  Future<String> updateOrder({
    File? image,
    required int orderId,
    String? notes,
    String? date,
    String? time,
    int? maintenanceCost,
  });

  Future<String> updateOrderDetails({
    required int orderDetailId,
    File? image,
    double? price,
    String? duration,
  });

  Future<String> createOrderDetailItem({
    required int orderDetailId,
    required int inventoryId,
    required int? quantity,
    required int vat,
  });
}

@LazySingleton(as: OrderRemoteDataSource)
@RestApi(baseUrl: '')
abstract class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @factoryMethod
  factory OrderRemoteDataSourceImpl(Dio dio, Configuration configuration) {
    return _OrderRemoteDataSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @override
  @GET('/api/admin/getMyOrders')
  Future<BaseResponse<List<OrderModel>>> getMyOrders();

  @override
  @GET('/api/admin/getInventoryItems')
  Future<BaseResponse<List<InventoryModel>>> getInventoryItems();

  @override
  @GET('/api/building')
  Future<BaseResponse<List<BuildingModel>>> getBuildings();

  @override
  @GET('/api/admin/getSupervisors')
  Future<BaseResponse<List<UserInfoModel>>> getSupervisors();

  @override
  @GET('/api/admin/getOrderDetails?order_id={orderId}')
  Future<BaseResponse<List<OrderDetailsModel>>> getOrderDetails({
    @Path() required int orderId,
  });

  @override
  @GET('/api/getServiceById?id={id}')
  Future<BaseResponse<ServiceModel>> getServiceById({
    @Path() required int id,
  });

  @override
  @GET('/api/getServiceById?id={id}')
  Future<BaseResponse<ServiceModel>> getSubServiceById({
    @Path() required int id,
  });

  @override
  @POST('/api/admin/editOrder')
  Future<String> updateOrder({
    @Part(contentType: 'image/jpeg') File? image,
    @Part(name: 'order_id') required int orderId,
    @Part() String? notes,
    @Part() String? date,
    @Part() String? time,
    @Part(name: 'maintenance_cost') int? maintenanceCost,
  });

  @override
  @POST('/api/admin/editOrderDetail')
  Future<String> updateOrderDetails({
    @Part(name: 'orderDetail_id') required int orderDetailId,
    @Part(contentType: 'image/jpeg') File? image,
    @Part() double? price,
    @Part() String? duration,
  });

  @override
  @POST('/api/admin/CreateOrderDetailItem')
  Future<String> createOrderDetailItem({
    @Part(name: 'order_detail_id') required int orderDetailId,
    @Part(name: 'inventory_id') required int inventoryId,
    @Part() required int? quantity,
    @Part() required int vat,
  });
}
