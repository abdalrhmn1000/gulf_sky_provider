import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/order/entities/inventory.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as order;
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/domain/order/usecases/create_order_detail_item_use_case.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<order.Order>>> getMyOrders();

  Future<Either<Failure, List<Inventory>>> getInventoryItems();

  Future<Either<Failure, List<OrderDetails>>> getOrderDetails({
    required int orderId,
  });

  Future<Either<Failure, Service>> getServiceById({
    required int id,
  });

  Future<Either<Failure, Service>> getSubServiceById({
    required int id,
  });

  Future<Either<Failure, String>> updateOrder({
    File? image,
    required int orderId,
    String? notes,
    String? date,
    String? time,
    int? maintenanceCost,
  });

  Future<Either<Failure, String>> updateOrderDetails({
    required int orderDetailId,
    File? image,
    double? price,
    String? duration,
  });

  Future<Either<Failure, String>> createOrderDetailItem({
    required  List<CreateOrderDetailItemUseCaseParams> items
  });
}
