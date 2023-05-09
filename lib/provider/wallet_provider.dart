
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_grocery/data/model/response/wallet_model.dart';
import 'package:flutter_grocery/data/repository/wallet_cart.dart';

import '../data/model/response/base/api_response.dart';
import '../helper/api_checker.dart';

class WalletProvider extends ChangeNotifier {
  final WalletRepo walletRepo;

  WalletProvider({@required this.walletRepo});
  String walletMoney = "0";

  Future<void> getWalletPrice(BuildContext context) async {
    if(walletMoney == "0") {
      ApiResponse apiResponse = await walletRepo.getWalletMoney();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        Map<String, dynamic> data = Map<String, dynamic>.from(apiResponse.response.data);
          WalletModel walletModel = WalletModel.fromJson(data['data']);
          if(walletModel.balance != null) {
            walletMoney = walletModel.balance;
          }
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

}
