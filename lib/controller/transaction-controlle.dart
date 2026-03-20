import 'dart:ffi';
import 'dart:io';

import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/constant/databaseTable/all-name-use-quary.dart';
import 'package:ccount/core/function/date-time.dart';
import 'package:ccount/core/function/filtter-sort-customer.dart';
import 'package:ccount/core/function/filtter-sort-transaction.dart';
import 'package:ccount/core/function/pric-formatter.dart';
import 'package:ccount/core/function/report-clients.dart';
import 'package:ccount/core/shared/show-pdf-report.dart';
import 'package:ccount/data/model/dbModel/box-model.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';
import 'package:ccount/data/model/dbModel/sequance-model.dart';
import 'package:ccount/data/model/dbModel/transcation-model.dart';
import 'package:ccount/data/repository/box-repo.dart';
import 'package:ccount/data/repository/customer-repo.dart';
import 'package:ccount/data/repository/sequance-repo.dart';
import 'package:ccount/data/repository/transcation-repo.dart';
import 'package:ccount/view/debt/client/view/note-client-edit.dart';
import 'package:ccount/view/debt/client/view/notes-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
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

  removeSelectedTransaction() async {
    num varAlikom = 0;
    num varLakom = 0;
    for (int i in selectedIndex) {
      await tranRep.deleteTransaction(rows[i].id!);
      varAlikom = varAlikom + rows[i].alikom!;
      varLakom = varLakom + rows[i].lakom!;

      rows.removeAt(i);
    }

    await custRep.minusCustomerAlikom(data!.id!, varAlikom);
    await custRep.minusCustomerLakom(data!.id!, varLakom);
    await boxRep.minusBoxAlikom(
        data!.customerTypeId!, data!.currncy!, varAlikom);
    await boxRep.minusBoxLakom(data!.customerTypeId!, data!.currncy!, varLakom);
    data = await custRep.getCustomerById(
      data!.id!,
    );

    total = data!.lakom! - data!.alikom!;
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
    if (alikom) {
      await custRep.minusCustomerAlikom(
          data!.id!, transEditeModle!.alikom!.abs());
      total = total! + transEditeModle!.alikom!.abs();
    } else {
      await custRep.minusCustomerLakom(
          data!.id!, transEditeModle!.lakom!.abs());
      total = total! - transEditeModle!.lakom!.abs();
    }

    await tranRep.deleteTransaction(transEditeModle!.id!);
    // await custRep.deleteCustomer(data!.id!);
    rows.removeWhere((element) => element.id == transEditeModle!.id!);
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
    var dib = num.tryParse(peice.text.replaceAll(",", ""));

    TransactionModel tranModee = TransactionModel(
      id: transEditeModle!.id,
      lakom: transEditeModle!.lakom != 0 ? dib : 0,
      // debit: num.tryParse(peice.text.replaceAll(",", "")),
      currencyCode: data!.currncy,
      alikom: transEditeModle!.alikom != 0 ? dib : 0,
      dateUser: date,
      timeUser: time,
      customerId: data!.id,
      remarks: nots.text,
    );

    await tranRep.updateTransaction(tranModee);
    int a = 0;
    int b = 0;
    for (TransactionModel not in rows) {
      a = a + 1;

      if (not.id == tranModee.id) {
        b = a;
        break;
      }
    }

    rows[b - 1] = tranModee;
    edit = false;
    update();
    Get.back();
  }

  addTransacrtion() async {
    if (formkeyTeansaction.currentState!.validate()) {
      TransactionModel tranModee;
      seqcuaneTransaction = seqcuaneTransaction! + 1;
      seqRep.incrementSequance("seqTransaction");
      BoxModel? bm;
      counter = counter + 1;
      if (isLow!) {
        // tranMod = TransactionModel(
        //   // id: seqcuaneTransaction,
        //   debit: num.tryParse(peice.text.replaceAll(",", "")),
        //   currencyCode: data!.currncy,
        //   dateUser: date,
        //   timeUser: time,
        //   customerId: data!.id,
        //   remarks: nots.text,
        // );
        var dib = num.tryParse(peice.text.replaceAll(",", ""));
        tranModee = TransactionModel(
          id: seqcuaneTransaction,
          lakom: 0,
          // debit: num.tryParse(peice.text.replaceAll(",", "")),
          currencyCode: data!.currncy,
          alikom: dib,
          dateUser: date,
          timeUser: time,
          customerId: data!.id,
          remarks: nots.text,
        );

        total = total! - dib!;

        // total = total! - num.tryParse(peice.text.replaceAll(",", ""))!;
        data!.alikom = data!.alikom! + dib;

        // rows.add({
        //   "dataTime": "${date}\n${time}",
        //   "nots": nots.text,
        //   "cradit": "0",
        //   "debit": peice.text,
        // });
        custRep.addCustomerAlikom(
            data!.id!, num.tryParse(peice.text.replaceAll(",", ""))!);
        //  CustomerModel? ssss=await   custRep.getCustomerById(5);

        // bm = await boxRep.getBoxByCustomerTypeCurrncy(
        //   data!.customerTypeId!,
        //   data!.currncy!,
        // );
        boxRep.addBoxAlikom(
          data!.customerTypeId!,
          data!.currncy!,
          num.tryParse(peice.text.replaceAll(",", ""))!,
        );

        tranRep.addTransaction(tranModee);
        rows.add(tranModee);
      } else if (!isLow!) {
        var cridt = num.tryParse(peice.text.replaceAll(",", ""));

        tranModee = TransactionModel(
          id: seqcuaneTransaction,
          lakom: cridt,
          currencyCode: data!.currncy,
          dateUser: date,
          timeUser: time,
          alikom: 0,
          customerId: data!.id,
          remarks: nots.text,
        );

        data!.lakom = data!.lakom! + cridt!;

        total = total! + cridt;

        custRep.addCustomerLakom(
            data!.id!, num.tryParse(peice.text.replaceAll(",", ""))!);
        // bm = await boxRep.getBoxByCustomerTypeCurrncy(
        //   data!.customerTypeId!,
        //   data!.currncy!,
        // );

        boxRep.addBoxLakom(
          data!.customerTypeId!,
          data!.currncy!,
          num.tryParse(peice.text.replaceAll(",", ""))!,
        );

        tranRep.addTransaction(tranModee);
        rows.add(tranModee);
      }

      // tranRep.addTransaction(tranMod!);
      update();
      Get.back();
      clearControllers();
    }
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
