import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/data/core/repositories/base_repository_impl.dart';
import 'package:gulf_sky_provider/data/core/utils/configuration.dart';
import 'package:gulf_sky_provider/data/order/datasources/remote/order_remote_datasource.dart';
import 'package:gulf_sky_provider/data/order/models/inventory_model/inventory_model.dart';
import 'package:gulf_sky_provider/data/order/models/order_details_model/order_details_model.dart';
import 'package:gulf_sky_provider/data/order/models/order_model/order_model.dart';
import 'package:gulf_sky_provider/data/order/models/service_model/service_model.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/utils/network/network_info.dart';
import 'package:gulf_sky_provider/domain/order/entities/inventory.dart';
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as order;
import 'package:gulf_sky_provider/domain/order/usecases/create_order_detail_item_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends BaseRepositoryImpl
    implements OrderRepository {
  final OrderRemoteDataSource remote;
  final NetworkInfo networkInfo;
  final Logger logger;
  final Configuration configuration;

  OrderRepositoryImpl(
    this.remote,
    this.networkInfo,
    this.logger,
    this.configuration,
  ) : super(networkInfo, logger);

  @override
  Future<Either<Failure, List<order.Order>>> getMyOrders() {
    return request(
      () async {
        final result = await remote.getMyOrders();
        return Right(result.data!.map((e) => e.toDomain()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, List<Inventory>>> getInventoryItems() {
    return request(
      () async {
        final result = await remote.getInventoryItems();
        return Right(result.data!.map((e) => e.toDomain()).toList()
          ..removeWhere((element) => element.quantity! < 1));
      },
    );
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getOrderDetails({
    required int orderId,
  }) {
    return request(
      () async {
        final result = await remote.getOrderDetails(orderId: orderId);
        return Right(result.data!.map((e) => e.toDomain()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, Service>> getServiceById({
    required int id,
  }) {
    return request(
      () async {
        final result = await remote.getServiceById(id: id);
        return Right(result.data!.toDomain());
      },
    );
  }

  @override
  Future<Either<Failure, Service>> getSubServiceById({
    required int id,
  }) {
    return request(
      () async {
        final result = await remote.getSubServiceById(id: id);
        return Right(result.data!.toDomain());
      },
    );
  }

  @override
  Future<Either<Failure, String>> updateOrder({
    File? image,
    required int orderId,
    String? notes,
    String? date,
    String? time,
    int? maintenanceCost,
  }) {
    return request(
      () async {
        final result = await remote.updateOrder(
          image: image,
          orderId: orderId,
          notes: notes,
          date: date,
          time: time,
          maintenanceCost: maintenanceCost,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, String>> updateOrderDetails({
    required int orderDetailId,
    File? image,
    double? price,
    String? duration,
  }) {
    return request(
      () async {
        final result = await remote.updateOrderDetails(
          orderDetailId: orderDetailId,
          image: image,
          price: price,
          duration: duration,
        );
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, String>> createOrderDetailItem(
      {required List<CreateOrderDetailItemUseCaseParams> items}) {
    return request(
      () async {
        for (var i in items) {
          await remote.createOrderDetailItem(
            orderDetailId: i.orderDetailId,
            inventoryId: i.inventoryId,
            quantity: i.quantity,
            vat: i.vat,
          );
        }
        return const Right('true');
      },
    );
  }
}
