import 'dart:developer';

import 'package:clean_architecture_analysis/src/architecture_core/failure/failure.dart';
import 'package:clean_architecture_analysis/src/architecture_core/failure/unknown_failure.dart';
import 'package:clean_architecture_analysis/src/architecture_core/result/result.dart';

abstract class BaseRepository {
  final bool debugMode;

  const BaseRepository({
    required this.debugMode,
  });

  Future<Result<D>> getResultBy<D>(Future<D?> Function() function) async {
    try {
      final D? data = await function();
      return Result<D>.success(data);
    } catch (error, stacktrace) {
      return _onCatchError<D>(error, stacktrace);
    }
  }

  Result<D> _onCatchError<D>(Object error, StackTrace stacktrace) {
    if (debugMode) {
      log(
        "BaseRepository error",
        error: error,
        stackTrace: stacktrace,
      );
    }
    final Failure failure = getFailureBy(error);
    return Result<D>.fail(failure);
  }

  Failure getFailureBy(dynamic error) {
    if (error is Failure) return error;
    return const UnknownFailure();
  }
}
