class WalletDetailsModel {
  bool? success;
  List<String>? msg;
  List<Wallet>? wallet;
  String? totalBalance;

  WalletDetailsModel({this.success, this.msg, this.wallet, this.totalBalance});

  WalletDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    // Handle msg (List or String)
    if (json['msg'] is List) {
      msg = List<String>.from(json['msg']);
    } else if (json['msg'] is String) {
      msg = [json['msg']];
    } else {
      msg = [];
    }

    // Handle wallet (List or null)
    if (json['wallet'] is List) {
      wallet = (json['wallet'] as List)
          .map((v) => Wallet.fromJson(v as Map<String, dynamic>))
          .toList();
    } else {
      wallet = [];
    }

    // Parse total_balance safely
    if (json['total_balance'] != null) {
      totalBalance = json['total_balance'].toString();
    } else {
      totalBalance = "0";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    if (wallet != null) {
      data['wallet'] = wallet!.map((v) => v.toJson()).toList();
    }
    data['total_balance'] = totalBalance;
    return data;
  }
}

class Wallet {
  int? walletId;
  int? userId;
  int? bookingId;
  int? categoryId;
  int? subCategoryId;
  String? categoryName;
  String? subCategoryName;
  int? amountStatus;
  String? amountStatusLabel;
  int? walletAmount;
  int? debitedAmount;
  int? paymentStatus; // new field
  String? paymentStatusLabel; // new field
  String? createtime;

  Wallet({
    this.walletId,
    this.userId,
    this.bookingId,
    this.categoryId,
    this.subCategoryId,
    this.categoryName,
    this.subCategoryName,
    this.amountStatus,
    this.amountStatusLabel,
    this.walletAmount,
    this.debitedAmount,
    this.paymentStatus,
    this.paymentStatusLabel,
    this.createtime,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    walletId = json['wallet_id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    amountStatus = json['amount_status'];
    amountStatusLabel = json['amount_status_label'];
    walletAmount = json['wallet_amount'];
    debitedAmount = json['debited_amount'];
    paymentStatus = json['payment_status']; // parse new field
    paymentStatusLabel = json['payment_status_label']; // parse new field
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_id'] = walletId;
    data['user_id'] = userId;
    data['booking_id'] = bookingId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['category_name'] = categoryName;
    data['sub_category_name'] = subCategoryName;
    data['amount_status'] = amountStatus;
    data['amount_status_label'] = amountStatusLabel;
    data['wallet_amount'] = walletAmount;
    data['debited_amount'] = debitedAmount;
    data['payment_status'] = paymentStatus; // include in toJson
    data['payment_status_label'] = paymentStatusLabel; // include in toJson
    data['createtime'] = createtime;
    return data;
  }
}
