import 'package:clean_architecture_analysis/src/architecture_core/failure/failure.dart';

enum ResultStatus {
  success,
  fail,
}

class Result<D> {
  final ResultStatus status;
  final D? data;
  final Failure? failure;

  const Result({
    required this.status,
    this.data,
    this.failure,
  });

  factory Result.success(D? data) {
    return Result(
      status: ResultStatus.success,
      data: data,
    );
  }

  factory Result.fail(Failure failure) {
    return Result(
      status: ResultStatus.fail,
      failure: failure,
    );
  }

  bool isFail() => status == ResultStatus.fail;

  Result<P> parseFail<P>() {
    return Result<P>(
      status: ResultStatus.fail,
      failure: failure,
    );
  }
}
