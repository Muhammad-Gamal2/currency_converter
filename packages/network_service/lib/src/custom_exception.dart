import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Used to differentiate between different types of exception
///
/// [internetException] happens when there's no internet connection.
///
/// [builtInException] when there's a known error happening or unknown error
/// so that we show a built-in text. (like 400 errors)
///
/// [serverDownException] when our server is down.
///
enum Errors {
  internetException,
  builtInException,
  serverDownException,
}

/// Handles different exceptions, whether they're internet, authentication, or
/// normal exceptions.
///
/// [message] is not necessary when [errorType] is [Errors.internetException]
class CustomException extends Equatable implements Exception {
  const CustomException({
    required this.errorType,
    this.message,
  });

  final Errors errorType;
  final String? message;

  @override
  String toString() {
    switch (errorType) {
      case Errors.internetException:
        return 'Please check your internet connection and try again.';
      case Errors.serverDownException:
        return 'Server is down. Please, try again later';
      case Errors.builtInException:
        return message ?? 'Something went wrong';
    }
  }

  @override
  List<Object?> get props => [errorType, message];
}

Never handleErrorsMsg(Response<dynamic>? response) {
  if (response != null) {
    if (response.statusCode! >= 500) {
      throw const CustomException(
        errorType: Errors.serverDownException,
      );
    }
    if (response.statusCode! == 429) {
      throw const CustomException(
        errorType: Errors.builtInException,
        message: 'Too many requests. Please try again later',
      );
    }
    if (response.statusCode != 200) {
      throw const CustomException(
        errorType: Errors.builtInException,
      );
    }
  }
  throw const CustomException(
    errorType: Errors.builtInException,
  );
}
