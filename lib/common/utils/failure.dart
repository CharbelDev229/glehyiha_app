import 'package:equatable/equatable.dart';

import '../constants/instances.dart';
import '../exceptions/common_exception.dart';
import '../helpers/request_manager.dart';

abstract class Failure extends Equatable {
  final int code;
  final String message;
  final List<dynamic> errors;
  final Object? extra;

  const Failure(this.code, this.message, {this.extra, this.errors = const []});
  @override
  List<Object> get props => [code, message, errors];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({
    required dynamic code,
    required String message,
    List<dynamic> errors = const [],
    Object? extra,
  }) : super(code, message, extra: extra, errors: errors);

  static ServerFailure raise(ApiResponse response) {
    logger.e(response.statusCode);

    if (response.statusCode == 422) {
      return ServerFailure(
        code: response.statusCode,
        message: response.message,
        errors: response.problems,
      );
    }

    return ServerFailure(
      code: response.statusCode,
      message: response.message,
    );
  }

  static ServerFailure onCatch({dynamic e}) {
    logger.e(e);
    return ServerFailure(
      code: 500,
      message: 'Une erreur est survenue',
    );
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.code, super.message);
}

