import 'package:ccount/core/constant/database_table/transaction_table.dart';

class TransactionModel {
  int? id;
  int? customerId;
  //laho
  num? lakom;
  //alihe
  num? alikom;
  String? date;
  String? remarks;
  //date server
  String? createdAt;
  String? dateUser;
  String? timeUser;
  int? transferCustomerId;
  String? currencyCode;

  TransactionModel(
      {this.id,
      this.customerId,
      this.lakom,
      this.alikom,
      // this.date,
      this.remarks,
      this.createdAt,
      this.transferCustomerId,
      this.currencyCode,
      this.dateUser,
      this.timeUser});

  factory TransactionModel.fromJison(Map<String, dynamic> map) {
    return TransactionModel(
      id: map[transactionId],
      customerId: map[transactionCustomerId] ?? 0,
      lakom: map[transactionLakom] ?? 0,
      alikom: map[transactionAlikom] ?? 0,
      // date: map[transactionDate] ?? '',
      remarks: map[transactionRemarks] ?? '',
      createdAt: map[transactionCreatedAt] ?? '',
      transferCustomerId: map[transactionTransferCustomerId] ?? 0,
      currencyCode: map[transactionCurrencyCode] ?? "",
      dateUser: map[transactionDateUser] ?? '',
      timeUser: map[transactionTimeUser] ?? '',
    );
  }

  Map<String, dynamic> toJison() {
    return {
      transactionId: id,
      transactionCustomerId: customerId,
      transactionLakom: lakom,
      transactionAlikom: alikom,
      // transactionDate: date,
      transactionRemarks: remarks,
      transactionCreatedAt: createdAt,
      transactionTransferCustomerId: transferCustomerId,
      transactionCurrencyCode: currencyCode,
      transactionDateUser: dateUser,
      transactionTimeUser: timeUser,
    };
  }
}
