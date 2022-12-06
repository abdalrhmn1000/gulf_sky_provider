import 'package:gulf_sky_provider/domain/core/entities/failures.dart';

enum PaginatedListStatus {
  initial,
  inProgress,
  success,
  failure,
  paginateInProgress,
  paginateFailure,
}

class BasePaginatedListState<T> {
  final PaginatedListStatus status;
  final List<T> items;
  final Failure? failure;
  final bool hasReachedMax;
  final int? totalRecords;

  BasePaginatedListState<T> initial() =>
      const BasePaginatedListState(status: PaginatedListStatus.initial);

  const BasePaginatedListState({
    this.status = PaginatedListStatus.initial,
    this.items = const [],
    this.failure,
    this.hasReachedMax = false,
    this.totalRecords,
  });

  BasePaginatedListState<T> copyWith({
    PaginatedListStatus? status,
    List<T>? items,
    Failure? failure,
    bool? hasReachedMax,
    int? totalRecords,
  }) {
    return BasePaginatedListState<T>(
      status: status ?? this.status,
      items: items ?? this.items,
      failure: failure ?? this.failure,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalRecords: totalRecords ?? this.totalRecords,
    );
  }
}
