
import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/domain/core/entities/failures.dart';
import 'package:gulf_sky_provider/domain/core/usecases/usecase.dart';
import 'package:gulf_sky_provider/domain/order/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateOrderDetailItemUseCase
    extends UseCase<String, List<CreateOrderDetailItemUseCaseParams>> {
  final OrderRepository repository;

  CreateOrderDetailItemUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(
      List<CreateOrderDetailItemUseCaseParams> params) {
    return repository.createOrderDetailItem(
      items:  params,
    );
  }
}

class CreateOrderDetailItemUseCaseParams {
  final int orderDetailId;
  final int inventoryId;
  final int? quantity;
  final int vat;

  CreateOrderDetailItemUseCaseParams({
    required this.orderDetailId,
    required this.inventoryId,
    required this.quantity,
    required this.vat,
  });
}
