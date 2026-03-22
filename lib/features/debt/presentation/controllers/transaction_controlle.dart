import 'dart:io';

import 'package:ccount/core/constant/app_image.dart';
import 'package:ccount/core/function/date_time.dart';
import 'package:ccount/core/function/filtter_sort_transaction.dart';
import 'package:ccount/core/function/pric_formatter.dart';
import 'package:ccount/core/function/report_clients.dart';
import 'package:ccount/core/shared/show_pdf_report.dart';
import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/customer_model.dart';
import 'package:ccount/features/debt/data/models/sequance_model.dart';
import 'package:ccount/features/debt/data/models/transcation_model.dart';
import 'package:ccount/features/debt/data/repositories/box_repo.dart';
import 'package:ccount/features/debt/data/repositories/customer_repo.dart';
import 'package:ccount/features/debt/data/repositories/sequance_repo.dart';
import 'package:ccount/features/debt/data/repositories/transcation_repo.dart';
import 'package:ccount/features/debt/presentation/client/view/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionControlle extends GetxController {
  // CustomerModel data = Get.arguments;
  CustomerModel? data;
  bool isSecure = false;
  GlobalKey<FormState> formkeyTeansaction = GlobalKey<FormState>();
  TextEditingController nots = TextEditingController();
  TextEditingController peice = TextEditingController();
  // TextEditingController time = TextEditingController();
  TextEditingController dateTimeTransaction = TextEditingController();

  @override
  void onClose() {
    super.onClose();

    nots.dispose();
    peice.dispose();
    dateTimeTransaction.dispose();
  }

  String? date;
  num? total;
  bool? isHigth;
  bool? choseEdit = false;

  // BoxModel? boxModel;
  // DateTime?
  // dataTimeTransactionSelander;
  String? time;
  File? fileProfileImageClient;
  String? pathImageClient;
  TransactionModel? transEditeModle;
  String? currncyCode;
  bool? isLow;
  String? nameClient;
  int? seqcuaneTransaction;
  // List<TransactionModel> transList = <TransactionModel>[];
  TransactionRepository tranRep = Get.find();
  SequanceRepo seqRep = Get.find();
  CustomerRepository custRep = Get.find();
  BoxRepository boxRep = Get.find();
  TransactionModel? tranMod;
  List<TransactionModel> rows = <TransactionModel>[];
  int counter = 0;
  bool state = false;
  bool selectRow = false;
  bool longePressState = false;

  // String?
  List<String> culomen = [
    "الزمن",
    "التفاصيل",
    " المبلغ",
  ];
  List<int> selectedIndex = [];
  selectRowAdd(int index) {
    selectedIndex.add(index);
    update();
  }

  changeChoseEdit() {
    choseEdit = true;
    update();
  }

  Future<void> _runAtomicWrite(
      Future<void> Function(DatabaseExecutor txn) operation) async {
    final db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      await operation(txn);
    });
  }

  Future<void> _applyLakomDelta(DatabaseExecutor txn, num delta) async {
    if (delta == 0 ||
        data?.id == null ||
        data?.customerTypeId == null ||
        data?.currncy == null) {
      return;
    }
    if (delta > 0) {
      await custRep.addCustomerLakom(data!.id!, delta, executor: txn);
      await boxRep.addBoxLakom(
        data!.customerTypeId!,
        data!.currncy!,
        delta,
        executor: txn,
      );
      return;
    }

    final absDelta = delta.abs();
    await custRep.minusCustomerLakom(data!.id!, absDelta, executor: txn);
    await boxRep.minusBoxLakom(
      data!.customerTypeId!,
      data!.currncy!,
      absDelta,
      executor: txn,
    );
  }

  Future<void> _applyAlikomDelta(DatabaseExecutor txn, num delta) async {
    if (delta == 0 ||
        data?.id == null ||
        data?.customerTypeId == null ||
        data?.currncy == null) {
      return;
    }
    if (delta > 0) {
      await custRep.addCustomerAlikom(data!.id!, delta, executor: txn);
      await boxRep.addBoxAlikom(
        data!.customerTypeId!,
        data!.currncy!,
        delta,
        executor: txn,
      );
      return;
    }

    final absDelta = delta.abs();
    await custRep.minusCustomerAlikom(data!.id!, absDelta, executor: txn);
    await boxRep.minusBoxAlikom(
      data!.customerTypeId!,
      data!.currncy!,
      absDelta,
      executor: txn,
    );
  }

  Future<void> _refreshCustomerTotals() async {
    if (data?.id == null) return;
    data = await custRep.getCustomerById(data!.id!);
    if (data == null) return;
    total = (data!.lakom ?? 0) - (data!.alikom ?? 0);
  }

  removeSelectedTransaction() async {
    if (data == null || selectedIndex.isEmpty) return;

    final normalizedIndices = selectedIndex
        .where((i) => i >= 0 && i < rows.length)
        .toSet()
        .toList()
      ..sort();
    if (normalizedIndices.isEmpty) {
      selectedIndex = [];
      update();
      return;
    }

    final selectedTransactions =
        normalizedIndices.map((i) => rows[i]).toList(growable: false);
    num totalSelectedAlikom = 0;
    num totalSelectedLakom = 0;
    for (final tx in selectedTransactions) {
      totalSelectedAlikom += tx.alikom ?? 0;
      totalSelectedLakom += tx.lakom ?? 0;
    }

    await _runAtomicWrite((txn) async {
      for (final tx in selectedTransactions) {
        if (tx.id != null) {
          await tranRep.deleteTransaction(tx.id!, executor: txn);
        }
      }
      await _applyAlikomDelta(txn, -totalSelectedAlikom);
      await _applyLakomDelta(txn, -totalSelectedLakom);
    });

    for (final i in normalizedIndices.reversed) {
      rows.removeAt(i);
    }
    await _refreshCustomerTotals();
    selectedIndex = [];
    update();
  }

  bool edit = false;
  DateTime? dt;
  getDataTransToEdit(TransactionModel tModel) {
    transEditeModle = tModel;

    edit = true;
    peice.text = chaongToPricFormatter(
        (-(transEditeModle!.alikom!) + (transEditeModle!.lakom!))
            .abs()
            .toString());
    nots.text = tModel.remarks!;
    date = transEditeModle!.dateUser;
    time = transEditeModle!.timeUser;
    // dateTimeTransaction.text =
    //     "${transEditeModle!.dateUser}${transEditeModle!.timeUser}";

    dt =
        parseToDateTime(transEditeModle!.dateUser!, transEditeModle!.timeUser!);
    dateTimeTransaction.text = "$date $time";

    update();
    // update()
  }

  deletTransaction(int index, bool alikom) async {
    if (data == null || transEditeModle?.id == null) return;

    final edited = transEditeModle!;
    await _runAtomicWrite((txn) async {
      await tranRep.deleteTransaction(edited.id!, executor: txn);
      await _applyAlikomDelta(txn, -(edited.alikom ?? 0));
      await _applyLakomDelta(txn, -(edited.lakom ?? 0));
    });

    rows.removeWhere((element) => element.id == edited.id);
    await _refreshCustomerTotals();
    transEditeModle = null;
    edit = false;
    update();
    Get.back();
  }

  selectRowAddAll() {
    selectedIndex = [];
    for (int i = 0; i < rows.length; i++) {
      selectedIndex.add(i);
    }

    update();
  }

  selectRowRmove(int index) {
    selectedIndex.remove(index);
    update();
  }

  longePressed() {
    longePressState = true;
    update();
  }

  selectRowRmoveAll() {
    selectedIndex = [];
    update();
  }

  get valeCheckAll => selectedIndex.length == rows.length;
  Future<void> openDialer(BuildContext context) async {
    if (data!.phone == null || data!.phone == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("not found phone")));
    } else {
      final Uri url = Uri(scheme: 'tel', path: data!.phone);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("لم يتم منح الإذن ❌")));
      }
    }
  }

  refrshEditeInfoClient() async {
    data = await custRep.getCustomerById(data!.id!);
    if (data!.pathImageProfile != AppImage.userProfile) {
      fileProfileImageClient = File(data!.pathImageProfile!);
      update();
    }

    // update();
  }

  goToNote() {
    Get.off(NotesPage(),
        arguments: {"id": data!.id, "name": data!.name},
        transition: Transition.leftToRight);
  }

  getSequancTransaction() async {
    var sequanc = await seqRep.getSequanceByName("seqTransaction");
    if (sequanc!.sequanceName == null) {
      seqRep.addSequance(SequanceModel(
        sequanceName: "seqTransaction",
        sequanceNumber: 0,
      ));
      seqcuaneTransaction = 0;
    } else {
      seqcuaneTransaction = sequanc.sequanceNumber!;
    }
  }

  clearControllers() {
    nots.clear();
    peice.clear();
    dateTimeTransaction.clear();
  }

  changeBottonLow() {
    isLow = true;
  }

  changeBottonHigth() {
    isLow = false;
  }

  selectTransaction() async {
    rows.clear();

    List<TransactionModel> transactions =
        await tranRep.getAllTransactionsByIdClient(data!.id!);

    rows = transactions;

    // if (transactions.isNotEmpty) {

    // for(TransactionModel tran in transactions){

    // counter = tran.key + 1

//
    // }
    // rows = transactions.asMap().entries.map((entry) {

    //   counter = entry.key + 1; // الترقيم يبدأ من 1
    //   TransactionModel t = entry.value;

    //   return {
    //     "dataTime": "${t.dateUser!}\n${t.timeUser!}",
    //     "nots": t.remarks ?? '',
    //     "cradit": t.credit!,
    //     "debit": t.debit!,
    //   };
    // }).toList();
    // }
    getSequancTransaction();
    state = true;
    // counter = transactions.length;
    update();
  }

  // setTransModelEdit(TransactionModel transEditeModlel){
  //   transEditeModle=transEditeModlel;
  //   nots.text=transEditeModle!.remarks!;
  //   pice.text=transEditeModle!.!;
  //   nots.text=transEditeModle!.remarks!;
  //   update();
  // }

  updateTransacrtion() async {
    if (data == null || transEditeModle?.id == null) return;
    final amount = num.tryParse(peice.text.replaceAll(",", ""));
    if (amount == null || amount <= 0) return;

    final oldTx = transEditeModle!;
    final updatedTx = TransactionModel(
      id: oldTx.id,
      lakom: oldTx.lakom != 0 ? amount : 0,
      currencyCode: data!.currncy,
      alikom: oldTx.alikom != 0 ? amount : 0,
      dateUser: date,
      timeUser: time,
      customerId: data!.id,
      remarks: nots.text,
    );
    final deltaLakom = (updatedTx.lakom ?? 0) - (oldTx.lakom ?? 0);
    final deltaAlikom = (updatedTx.alikom ?? 0) - (oldTx.alikom ?? 0);

    await _runAtomicWrite((txn) async {
      await tranRep.updateTransaction(updatedTx, executor: txn);
      await _applyLakomDelta(txn, deltaLakom);
      await _applyAlikomDelta(txn, deltaAlikom);
    });

    int a = 0;
    int b = 0;
    for (TransactionModel not in rows) {
      a = a + 1;

      if (not.id == updatedTx.id) {
        b = a;
        break;
      }
    }

    rows[b - 1] = updatedTx;
    transEditeModle = updatedTx;
    await _refreshCustomerTotals();
    edit = false;
    update();
    Get.back();
  }

  addTransacrtion() async {
    if (!formkeyTeansaction.currentState!.validate()) return;
    if (data == null || isLow == null) return;

    final amount = num.tryParse(peice.text.replaceAll(",", ""));
    if (amount == null || amount <= 0) return;

    seqcuaneTransaction = (seqcuaneTransaction ?? 0) + 1;
    counter = counter + 1;

    final tranModee = TransactionModel(
      id: seqcuaneTransaction,
      lakom: isLow! ? 0 : amount,
      currencyCode: data!.currncy,
      alikom: isLow! ? amount : 0,
      dateUser: date,
      timeUser: time,
      customerId: data!.id,
      remarks: nots.text,
    );

    await _runAtomicWrite((txn) async {
      await seqRep.incrementSequance("seqTransaction", executor: txn);
      await tranRep.addTransaction(tranModee, executor: txn);
      await _applyLakomDelta(txn, tranModee.lakom ?? 0);
      await _applyAlikomDelta(txn, tranModee.alikom ?? 0);
    });

    rows.add(tranModee);
    await _refreshCustomerTotals();
    update();
    Get.back();
    clearControllers();
  }

  adTransaction(String curncy, String Name) {}

  getDataTimerCelunder(
    BuildContext context,
  ) async {
    Map<String, dynamic> dataTimeF = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.dateAndTime, null);

    date = dataTimeF["date"];
    time = dataTimeF["time"];
    dateTimeTransaction.text = "$date $time";
    update();
  }

  getDataTimerCelunderEdit(BuildContext context, DateTime dt) async {
    Map<String, dynamic> dataTimeF = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.dateAndTime, dt);

    date = dataTimeF["date"];
    time = dataTimeF["time"];
    dateTimeTransaction.text = "$date $time";
    update();
  }

  /*
 List<dynamic> items,
  String fromDate,
  String toDate,
  String AddressTow,
  String adressOne,
  String nameCommerss,
  String numFax,
  String numPhon,
  String nameCurrncy,
  String nameReport,
  */
  // List<String>? culomens;
  // List<double>? culmenWidth;
  // num? totalAlikom;
  // num? totalLakom;
  // Future<void> exportPdfTransaction(
  //   BuildContext context,
  // ) async {

  //   totalLakom = 0;
  //   totalAlikom = 0;
  //   final itemsData = await rows.map((item) {
  //     totalAlikom = totalAlikom! + item.debit!;
  //     totalLakom = totalLakom! + item.credit!;
  //     return [
  //       chaongToPricFormatter(
  //           ((item.debit ?? 0) - (item.credit ?? 0)).toString()),
  //       chaongToPricFormatter((item.debit ?? 0).abs().toString()),
  //       chaongToPricFormatter((item.credit ?? 0).abs().toString()),
  //       "${item.remarks ?? ""}",
  //       "${item.dateUser}\n${item.timeUser}",
  //     ];
  //   }).toList();

  //   culomens = ["الصافي", "له", "عليه", "التفاصيل", "التاريخ"];
  //   culmenWidth = [0.20, 0.30, 0.1666, 0.1666, 0.1666];
  //   // 4: pw.FractionColumnWidth(0.30),
  //   // 3: pw.FractionColumnWidth(0.20),
  //   // 2: pw.FractionColumnWidth(0.1666),
  //   // 1: pw.FractionColumnWidth(0.1666),
  //   // 0: pw.FractionColumnWidth(0.1666),
  //   final pdfBytes = await generateInvoicePdfBytes(
  //       itemsData,
  //       "18/18/18",
  //       "18.18/18",
  //       "شارع السبعين",
  //       "ذمار",
  //       "الحندي للتحاره العامه",
  //       "004259526",
  //       "0096775355982",
  //       data!.currncy!,
  //       "كشف حساب تقرير للعميل ",
  //       AppImage.userProfile,
  //       culomens!,
  //       culmenWidth!,
  //       totalLakom!,
  //       totalAlikom!,
  //       "اسم العميل / ${data!.name}");
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PdfPreviewPage(pdfBytes: pdfBytes),
  //     ),
  //   );
  // }
  bool tranEdit = false;
  initDateTime() {
    date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    time = DateFormat('hh:mm a').format(DateTime.now());
    dateTimeTransaction.text = "$date $time";
    update();
  }

  changeBollEdit() {
    edit = false;
    update();
  }

  changeEditTrans() {
    tranEdit = true;
    update();
  }

  changeSecure() {
    isSecure = !isSecure;
    update();
  }

  bool stateData = false;
  initPage() async {
    print("=================nt CustmerID = Get.arguments;===============");
    // print("===============${CustmerID}=================");
    data = await custRep.getCustomerById(Get.arguments);
    print("==============${data!.id!}==================");
    print("==============${data!.name!}==================");
    total = data!.lakom! - data!.alikom!;

    pathImageClient = data!.pathImageProfile;
    if (pathImageClient != AppImage.userProfile) {
      fileProfileImageClient = File(pathImageClient!);
    }

    selectTransaction();
    stateData = true;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await initPage();
    // int CustmerID = Get.arguments;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///

  // controllers report
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateConstroller = TextEditingController();

  String vleuGropOrder = "new";

  bool checkBoxViewZeroReport = false;

  changeCheckBoxZero() {
    checkBoxViewZeroReport = !checkBoxViewZeroReport;
    update();
  }

  changeGrupe(String vale) {
    vleuGropOrder = vale;
    update();
  }

  List<TransactionModel> clearZeroItems(List<TransactionModel> dataFineches) {
    return dataFineches
        .where((element) => ((element.lakom)! - (element.alikom!)) != 0)
        .toList();
  }

  num totalAfterTransaction = 0;

  toDynamicList(List<TransactionModel>? dataFinech) {
    totalAlikom = 0;
    totalLakom = 0;
    // ☆*: .｡. o(≧▽≦)o .｡.:*☆
    return dataFinech!.map((item) {
      totalAlikom = totalAlikom + item.alikom!;
      totalLakom = totalLakom + item.lakom!;
      totalAfterTransaction += ((-item.alikom!) + item.lakom!);

      return [
        chaongToPricFormatter((totalAfterTransaction).toString()),
        chaongToPricFormatter((item.lakom ?? 0).abs().toString()),
        chaongToPricFormatter((item.alikom ?? 0).abs().toString()),
        "${item.remarks ?? ""}",
        "${item.dateUser}\n${item.timeUser}",
      ];
    }).toList();
  }

  bool stateReport = true;
  List<String>? culomens;
  List<double>? culmenWidth;
  num totalAlikom = 0;
  num totalLakom = 0;
  List<TransactionModel>? dataFinech;

  Future<void> exportPdf(
    BuildContext context,
    List<TransactionModel> dataFinech,
    String currncyName,
  ) async {
    stateReport = false;
    update();
    culomens = ["الرصيد", "له", "عليه", "التفاصيل", "التاريخ"];
    culmenWidth = [0.20, 0.30, 0.1666, 0.1666, 0.1666];

    // تحويل إلى rows
    final items = toDynamicList(sortByTransaction(
        filteredZeroTransaction(checkBoxViewZeroReport, dataFinech),
        vleuGropOrder));

    // توليد PDF
    final pdfBytes = await generateInvoicePdfBytes(
        items,
        fromDateController.text,
        toDateConstroller.text,
        "شارع السبعين",
        "ذمار",
        "الحندي للتجارة العامة",
        "004259526",
        "0096775355982",
        data!.currncy!,
        "كشف حساب عمليات العميل ",
        pathImageLogo ?? AppImage.userProfile,
        culomens!,
        culmenWidth!,
        totalLakom,
        totalAlikom,
        "اسم العميل / ${data!.name}");

    // عرض المعاينة
    // await Printing.layoutPdf(onLayout: (_) async => pdfBytes);
    stateReport = true;
    update();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PdfPreviewPage(pdfBytes: pdfBytes)));
  }

  //

  String? fromDate;
  String? toDate;
  String? AddressTo;
  String? adressOne;
  String? nameCommerss;
  String? numFax;
  String? numPhon;
  String? nameCurrncy;
  String? nameReport;
  String? pathImageLogo;

  //

  Future<String> getDataTimerCelunderDateOnlyFromDate(
      BuildContext context, DateTime? initialDate) async {
    Map<String, dynamic> mapDate = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.date, initialDate);

    return mapDate["date"];
  }

  sortByDate() {}

  onTapReport(List<TransactionModel> datatTransaction) {
    if (datatTransaction.isEmpty) {
      fromDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      toDateConstroller.text = fromDateController.text;
    } else {
      fromDateController.text = datatTransaction.first.dateUser!;
      toDateConstroller.text =
          datatTransaction[datatTransaction.length - 1].dateUser!;
    }
    update();
  }

  fromDateReport(
    BuildContext context,
  ) async {
    fromDateController.text = await getDataTimerCelunderDateOnlyFromDate(
        context, parseDate(fromDateController.text));
    update();
  }

  toDateReport(
    BuildContext context,
  ) async {
    toDateConstroller.text = await getDataTimerCelunderDateOnlyFromDate(
        context, parseDate(toDateConstroller.text));
    update();
  }
}

