
class WalletModel {
  String? balance;

  WalletModel(
      {required String balance}) {
    this.balance = balance;
  }

  WalletModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}
