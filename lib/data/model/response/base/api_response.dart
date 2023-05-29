import 'package:dio/dio.dart';

class ApiResponse {
  final dynamic response;
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue) : response = null,
        error = errorValue;

  ApiResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}
