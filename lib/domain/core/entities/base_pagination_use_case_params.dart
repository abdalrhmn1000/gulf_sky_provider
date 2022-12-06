class BasePaginationUseCaseParams {
  int? skip;
  int limit;

  BasePaginationUseCaseParams(
    this.limit,
    this.skip,
  );
}
