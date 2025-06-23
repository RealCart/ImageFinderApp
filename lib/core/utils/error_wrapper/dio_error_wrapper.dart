import 'package:dio/dio.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';

Failure dioErrorWrapper(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutFailure(
        errorMessage: "Сервер не отвечает. Попробуйте по-позже",
      );
    case DioExceptionType.connectionError:
      return NetworkFailure(
        errorMessage: "Проверьте подключение к интернету",
      );
    case DioExceptionType.badResponse:
      final String msg =
          (e.response?.data is Map && e.response!.data["message"] is String)
              ? e.response!.data["message"] as String
              : "Ошибка сервера!";
      return BadResponseFailure(errorMessage: msg);
    default:
      return UnexpectedFailure(
        errorMessage: e.message ?? "Неизвестная ошибка. Попробуйте по-позже",
      );
  }
}
