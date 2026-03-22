// import 'package:ccount/core/constant/databaseTable/currencie-table.dart';

// class CurrencyModel {
//   int? id;
//   String name;
//   String code;

//   CurrencyModel({
//     this.id,
//     required this.name,
//     required this.code,
//   });

//   factory CurrencyModel.fromJson(Map<String, dynamic> map) {
//     return CurrencyModel(
//       id: map[currencyId] ?? 0,
//       name: map[currencyName] ?? '',
//       code: map[currencyCode] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       // currencyId: id,
//       currencyName: name,
//       currencyCode: code,
//     };
//   }
// }

import 'package:ccount/core/constant/database_table/currencie_table.dart';

class CurrencyModel {
  int? id;
  String? name;
  String? code;
  String? customerType;

  CurrencyModel({
    this.id,
    this.name,
    this.code,
    this.customerType,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> map) {
    return CurrencyModel(
      id: map[currencyId], // إزالة ?? 0
      name: map[currencyName],
      code: map[currencyCode],
      customerType: map[currencyTypeCustomer],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // currencyId: id, // إزالة التعليق
      currencyName: name,
      currencyCode: code,
      currencyTypeCustomer: customerType,
    };
  }
}
