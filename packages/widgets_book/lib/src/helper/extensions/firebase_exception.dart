import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:widgets_book/src/helper/network/domain/api_error.dart';

extension FirebaseExceptionX on FirebaseException {
  ApiError toApiError() {
    var apiError = ApiError();
    apiError = apiError.copyWith(
      code: code,
      message: message,
    );
    return apiError;
  }
}

extension FirebaseAuthExceptionX on FirebaseAuthException {
  ApiError toApiError() {
    var apiError = ApiError();
    apiError = apiError.copyWith(
      code: code,
      message: message,
    );
    return apiError;
  }
}

extension DioExceptionX on DioException {
  ApiError toApiError() {
    var apiError = ApiError();
    return apiError = apiError.copyWith(
      code: response?.statusCode.toString(),
      message: message,
    );
  }
}