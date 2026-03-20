import 'package:ccount/core/function/date-time.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';

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

List<CustomerModel> filteredZero(
  bool checkBoxViewZeroReport,
  List<CustomerModel> dataFinech,
) {
  return checkBoxViewZeroReport
      ? dataFinech
      : dataFinech.where((item) {
          final total = (item.lakom ?? 0) - (item.alikom ?? 0);
          return total != 0;
        }).toList();
}

List<CustomerModel> sortBy(List<CustomerModel> filtered, String sortedBy) {
  filtered.sort((a, b) {
    final aTotal = ((a.lakom ?? 0) - (a.alikom ?? 0)).toDouble();
    final bTotal = ((b.lakom ?? 0) - (b.alikom ?? 0)).toDouble();

    if (sortedBy == "up") {
      // "المبالغ الاعلى" -> ترتيب تنازلي
      return bTotal.compareTo(aTotal);
    } else {
      // "المبالغ الاقل" -> ترتيب تصاعدي
      return aTotal.compareTo(bTotal);
    }
  });
  return filtered;
}

List<CustomerModel> sortByDate(List<CustomerModel> filtered,
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
