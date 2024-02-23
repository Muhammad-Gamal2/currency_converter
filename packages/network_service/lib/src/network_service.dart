import 'package:dio/dio.dart';
import 'package:network_service/src/custom_exception.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class NetworkService {
  NetworkService({
    Dio? dio,
    String? baseUrl,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl ?? '',
              ),
            )
          ..interceptors.add(
            QueuedInterceptorsWrapper(
              onResponse: (response, handler) {
                if (response.statusCode != 200) {
                  handleErrorsMsg(response);
                }
                handler.next(response);
              },
            ),
          )
          ..interceptors.add(TalkerDioLogger());

  final Dio _dio;

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      if (response.data is List) {
        return {'data': response.data};
      }

      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          handleErrorsMsg(error.response);
        case DioExceptionType.cancel:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw const CustomException(
            errorType: Errors.serverDownException,
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.unknown:
        case DioExceptionType.connectionError:
          throw const CustomException(
            errorType: Errors.internetException,
          );
      }
    }
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      if (response.data == '') {
        return {};
      }
      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          handleErrorsMsg(error.response);
        case DioExceptionType.cancel:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw const CustomException(
            errorType: Errors.serverDownException,
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.unknown:
        case DioExceptionType.connectionError:
          throw const CustomException(
            errorType: Errors.internetException,
          );
      }
    }
  }

  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          handleErrorsMsg(error.response);
        case DioExceptionType.cancel:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw const CustomException(
            errorType: Errors.serverDownException,
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.unknown:
        case DioExceptionType.connectionError:
          throw const CustomException(
            errorType: Errors.internetException,
          );
      }
    }
  }

  Future<Map<String, dynamic>> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          handleErrorsMsg(error.response);
        case DioExceptionType.cancel:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw const CustomException(
            errorType: Errors.serverDownException,
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.unknown:
        case DioExceptionType.connectionError:
          throw const CustomException(
            errorType: Errors.internetException,
          );
      }
    }
  }

  Future<Map<String, dynamic>> uploadFiles(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required FormData formData,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        url,
        queryParameters: queryParameters,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          handleErrorsMsg(error.response);
        case DioExceptionType.cancel:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw const CustomException(
            errorType: Errors.serverDownException,
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.unknown:
        case DioExceptionType.connectionError:
          throw const CustomException(
            errorType: Errors.internetException,
          );
      }
    }
  }
}
