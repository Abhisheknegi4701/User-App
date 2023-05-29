
import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class WalletRepo {
  final DioClient dioClient;
  WalletRepo({required this.dioClient});

  Future<ApiResponse> getWalletMoney() async {
    try {
      final response = await dioClient.get(AppConstants.WALLET);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTransactionList() async {
    try {
      final response = await dioClient.get(AppConstants.TRANSACTION);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}