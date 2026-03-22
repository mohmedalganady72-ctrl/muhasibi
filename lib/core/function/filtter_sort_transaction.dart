import 'package:ccount/core/function/date_time.dart';
import 'package:ccount/features/debt/data/models/customer_model.dart';
import 'package:ccount/features/debt/data/models/transcation_model.dart';

/*

checkBoxViewZeroReport
        ? dataFinech
        : dataFinech.where((item) {
            final total = (item.payables ?? 0) - (item.receivables ?? 0);
            return total != 0;
          }).toList();

    // // ترتيب البيانات
    // if (vleuGropOrder == "up") {
    //   filtered.sort((a, b) => ((b.payables ?? 0) - (b.receivables ?? 0))
    //       .compareTo((a.payables ?? 0) - (a.receivables ?? 0)));
    // } else if (vleuGropOrder == "down") {
    //   filtered.sort((a, b) => ((a.payables ?? 0) - (a.receivables ?? 0))
    //       .compareTo((b.payables ?? 0) - (b.receivables ?? 0)));
    // }

    filtered.sort((a, b) {
      final aTotal = ((a.payables ?? 0) - (a.receivables ?? 0)).toDouble();
      final bTotal = ((b.payables ?? 0) - (b.receivables ?? 0)).toDouble();

      if (vleuGropOrder == "up") {
        // "المبالغ الاعلى" -> نريد الأكبر أولاً => ترتيب تنازلي
        return bTotal.compareTo(aTotal);
      } else {
        // "المبالغ الاقل" -> نريد الأصغر أولاً => ترتيب تصاعدي
        return aTotal.compareTo(bTotal);
      }


  */

List<TransactionModel> filteredZeroTransaction(
  bool checkBoxViewZeroReport,
  List<TransactionModel> dataFinech,
) {
  return checkBoxViewZeroReport
      ? dataFinech
      : dataFinech.where((item) {
          final total = (item.lakom ?? 0) - (item.alikom ?? 0);
          return total != 0;
        }).toList();
}

List<TransactionModel> sortByTransaction(
    List<TransactionModel> filtered, String sortedBy) {
  filtered.sort((a, b) {
    if (sortedBy == "new") {
      // "المبالغ الاعلى" -> ترتيب تنازلي
      return parseDate(b.dateUser!).compareTo(parseDate(a.dateUser!));
    } else {
      // "المبالغ الاقل" -> ترتيب تصاعدي
      return parseDate(a.dateUser!).compareTo(parseDate(b.dateUser!));
    }
  });
  return filtered;
}

// List<TransactionModel> sortByTransaction(
//     List<TransactionModel> filtered, String sortedBy) {
//   filtered.sort((aa, bb) {
//     final a = parseDate(aa.dateUser!);
//     final b = parseDate(bb.dateUser!);

//     if (sortedBy == "new") {
//       // "المبالغ الاعلى" -> ترتيب تنازلي
//       return b.compareTo(a);
//     } else {
//       // "المبالغ الاقل" -> ترتيب تصاعدي
//       return a.compareTo(b);
//     }
//   });
//   return filtered;
// }
List<TransactionModel> sortByDateTransaction(List<TransactionModel> filtered,
    {bool descending = true}) {
  filtered.sort((a, b) {
    // تحويل النص إلى تاريخ
    DateTime dateA = parseDate(a.date ?? "01/01/1970");
    DateTime dateB = parseDate(b.date ?? "01/01/1970");

    // ترتيب تصاعدي أو تنازلي
    if (descending) {
      return dateB.compareTo(dateA); // الأعلى أولاً
    } else {
      return dateA.compareTo(dateB); // الأقل أولاً
    }
  });
  return filtered;
}

