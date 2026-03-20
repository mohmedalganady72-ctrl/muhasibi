import 'dart:async';
import 'dart:io';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/constant/app-page.dart';

import 'package:ccount/core/function/date-time.dart';
import 'package:ccount/core/function/filtter-sort-customer.dart';
import 'package:ccount/core/function/image-picker.dart';
import 'package:ccount/core/function/pric-formatter.dart';
import 'package:ccount/core/function/report-clients.dart';
import 'package:ccount/core/function/snackBar-massage-fun.dart';

import 'package:ccount/core/shared/show-pdf-report.dart';
import 'package:ccount/core/theme/themeMode/Text-style.dart';
import 'package:ccount/data/model/dbModel/sequance-model.dart';
import 'package:ccount/data/repository/sequance-repo.dart';

import 'package:ccount/data/model/dbModel/box-model.dart';
import 'package:ccount/data/model/dbModel/currency-model.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';
import 'package:ccount/data/repository/box-repo.dart';
import 'package:ccount/data/repository/currency-repo.dart';
import 'package:ccount/data/repository/customer-repo.dart';
import 'package:ccount/view/debt/client/view/add-new-client-screen.dart';
import 'package:ccount/view/debt/client/view/currncy-screen.dart';
import 'package:ccount/view/debt/client/view/load-contact-screen.dart';
import 'package:ccount/view/debt/client/view/page-client-transaction.dart';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ClientController extends GetxController {
  // key form add new Client
  GlobalKey<FormState> formNewClient = GlobalKey<FormState>();

// all controllers editing start
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientPhoneController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController currncyController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateConstroller = TextEditingController();
  TextEditingController pathImageProfileController = TextEditingController();
// all controllers editing end
  loadFromContact(Contact cont) {
    cleareControllers();
    clientNameController.text = cont.displayName;
    clientPhoneController.text = cont.phones.first.number;

    Get.back();
  }
/*
 state > stateFratechData


 */

  Map<String, List<CustomerModel>> MapClientByCurrncy =
      <String, List<CustomerModel>>{};

  bool isSelected = false;
  Map<String, BoxModel> boxM = <String, BoxModel>{};

// **************************************************All variables start****************************************************************//
// this repostrise start
  CustomerRepository customerRep = Get.find();

  BoxRepository boxRep = Get.find();
  SequanceRepo seqRep = Get.find();
  CurrencyRepository currncyRep = Get.find();

// this repostrise end

// this Modeles start
  CustomerModel? clientModel;
  CurrencyModel? currncyM;
  BoxModel? boxMod;
// this Modeles end

// this normal variables start
  bool stateFratechData = false;
  // String vleuGropOrderTrans = "new";
  String vleuGropOrder = "old";
  // String vleuGropOrder = "up";
  String vleuGropOrderFilter = "all";
  String? clientDate;
  bool stateContact = true;
  RxString? selectrtCurrncy;
  num totalAlikom = 0;
  num totalLakom = 0;
  bool isSecure = false;
  bool st = false;
  int selectee = 0;
  bool statwid = false;
  bool stateReport = true;

  bool? issel;
  int? seqcuaneClient;
  bool checkBoxViewZeroReport = false;
  File? fileProfileImageClient;
  Widget? iconErorr;
// this normal variables end

  // all lists start

  List<String>? culomen;
  List<double>? culmenWidth;
  List<CustomerModel> filterClientList = [];
  List<CustomerModel> data = [];
  List<String> crncList = [];
  // all lists end
// this list localy

// **************************************************All variables end****************************************************************//

// **************************************************All Meathodes start****************************************************************//

// disposed all controller before closed

// meathod of routes start
  goToAddNewCurrncy() {
    Get.off(() => CurrncyScreen(),
            // Get.to(AppPage.currncyPage,
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 500))!
        .then((_) => updateCurrncy());
  }

  goToAddNewClient() {
    cleareAllControllers();
    pathImageProfileController.text = AppImage.userProfile;
    clientDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    dateTimeController.text = "$clientDate ";
    Get.off(() => AddNewClientScreen(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 500));
    //     !
    // .then((_) => updateCurrncy());
  }

  goToPageClientTransaction(int index, int client) {
    Get.off(
      () => PageClientTransaction(),
      // AppPage.pageClientTransaction,
      transition: Transition.leftToRight,
      duration: Duration(milliseconds: 300),
      arguments: index == -1 ? client : filterClientList[client - 1].id!,
    )!
        .then((_) => featchData());
    // cleareAllControllers();
  }

// meathod of routes end

//********************* meathod of form create report start*****************//
  changeCheckBoxZero() {
    checkBoxViewZeroReport = !checkBoxViewZeroReport;
    update();
  }

  // changeGrupeTrans(String vale) {
  //   vleuGropOrderTrans = vale;
  //   update();
  // }

  changeGrupe(String vale) {
    vleuGropOrder = vale;
    update();
  }

  changeGrupeFilter(String vale) {
    vleuGropOrderFilter = vale;
    update();
  }

  changeGrupeOrder(String vale) {
    vleuGropOrder = vale;
    update();
  }

// filtter list if chois not view zero accountes
  List<CustomerModel> clearZeroItems(List<CustomerModel> dataFineches) {
    return dataFineches
        .where((element) => ((element.lakom)! - (element.alikom!)) != 0)
        .toList();
  }

// meathode change frome CustomerModel List to Dynamic List satrt
  toDynamicList(List<CustomerModel>? dataFinech) {
    totalAlikom = 0;
    totalLakom = 0;
    // ☆*: .｡. o(≧▽≦)o .｡.:*☆
    return dataFinech!.map((item) {
      totalAlikom += item.alikom!;
      totalLakom += item.lakom!;
      return [
        chaongToPricFormatter(
            ((item.lakom ?? 0) - (item.alikom ?? 0)).toString()),
        chaongToPricFormatter((item.lakom ?? 0).abs().toString()),
        chaongToPricFormatter((item.alikom ?? 0).abs().toString()),
        "${item.phone ?? ""}",
        "${item.name ?? ""}"
      ];
    }).toList();
  }
// meathode change frome CustomerModel List to Dynamic List end

// meathode export to PDF start

  Future<void> exportPdf(
    BuildContext context,
    List<CustomerModel> dataFinech,
    String currncyName,
  ) async {
    stateReport = false;
    update();
    // culomen report
    culomen = ["الصافي", "له", "عليه", "رقم الهاتف", "الاسم"];

    // width of culomen report
    culmenWidth = [0.30, 0.20, 0.1666, 0.1666, 0.1666];

    //(Change to Dynamiv List and Filtering zero account and sort)
    final items = toDynamicList(
        sortBy(filteredZero(checkBoxViewZeroReport, dataFinech), "up"));

    // (Create PDF file)
    final pdfBytes = await generateInvoicePdfBytes(
      items,
      // date start report
      fromDateController.text,
      // end start report
      toDateConstroller.text,
      // address main three
      "شارع السبعين",
      // address main tow
      "ذمار",
      // name commers main
      "الحندي للتجارة العامة",
      // fax tel
      "004259526",
      //  tel mobile
      "0096775355982",
      // name currncy report
      currncyName,
      //  title   report
      "كشف حساب تقريري للعملاء",
      // logo report
      AppImage.userProfile,
      // culomen report
      culomen!,
      // culomen width report
      culmenWidth!,
      // cradit
      totalAlikom,
      // didbet
      totalLakom,
      "",
    );

    // (Route to page Printer)
    stateReport = true;
    update();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PdfPreviewPage(pdfBytes: pdfBytes)));
  }

// meathode export to PDF end
// get upper date and lowre date from client START

  onTapReport(List<CustomerModel> data) {
    if (data.isEmpty) {
      fromDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      toDateConstroller.text = fromDateController.text;
    } else {
      fromDateController.text = data.first.date!;
      toDateConstroller.text = data[data.length - 1].date!;
    }
    update();
  }

// get upper date and lowre date from client end

//********************* meathod of form create report end*****************//

  // meathode filttering searchinge start
  filter(String query) {
    if (query.isEmpty) {
      filterClientList = data;
    } else {
      filterClientList = data
          .where((element) =>
              element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    update();
  }
  // meathode filttering searchinge end

// featch data on inite start

  featchData() async {
    await getCurrncy2();
    await getItem(selectee, crncList[selectee]);
  }

// featch data on inite end

  setIconWorning() {
    iconErorr = Icon(
      Iconsax.info_circle,
      color: AppColor.error,
    );
    update();
  }

  setIconWorningTrue() {
    iconErorr = null;
    update();
  }

// get item of screen tab bar start
  getItem(int index, String currncyCode) async {
    issel = false;
    selectee = index;
    statwid = false;
    data.clear();
    data = await customerRep.getCustomerByCurrencyCode("client", currncyCode);

    boxMod = await boxRep.getBoxByCustomerTypeCurrncy("client", currncyCode);

    filterClientList = data;
    statwid = true;
    update();
  }

// get item of screen tab bar end
// get sequance client (Customer) start
  getSequancClient() async {
    var sequanc = await seqRep.getSequanceByName("seqClient");

    if (sequanc!.sequanceName == null) {
      seqRep.addSequance(SequanceModel(
        sequanceName: "seqClient",
        sequanceNumber: 0,
      ));
      seqcuaneClient = 0;
    } else {
      seqcuaneClient = sequanc.sequanceNumber!;
    }
  }
// get sequance client (Customer) end

// update currncy Start
  updateCurrncy() async {
    final currncyLisr = await currncyRep.getAllCurrenciesCustomerType("client");
    crncList.clear();

    for (var e in currncyLisr) {
      crncList.add(e.code!);
    }

    update();
  }
// update currncy end

  currebtselect() {
    issel = !issel!;
    update();
  }

  // get currncy on inite start
  getCurrncy2() async {
    final currncyLisr = await currncyRep.getAllCurrenciesCustomerType("client");
    // stateGetCurrncy = false;
    crncList.clear();
    if (currncyLisr.isEmpty) {
      currncyM = CurrencyModel(
          code: "YER", customerType: "client", name: "YEMEN REAL");
      currncyRep.addCurrency(currncyM!);

      await boxRep.insertBox(BoxModel(
          BTCustomer: "client", currncyCode: "YER", alihe: 0, laho: 0));

      crncList.add(currncyM!.code!);
    } else {
      crncList.clear();

      for (var e in currncyLisr) {
        crncList.add(e.code!);
      }
    }
    getSequancClient();

    // stateGetCurrncy = true;
    update();
  }

  // get currncy on inite end

// icon salse selcted start
  changeSecureIcon() {
    isSecure = !isSecure;
    update();
  }
// icon salse selcted end

// add new client start

  addNewClient(BuildContext context) async {
    if (formNewClient.currentState!.validate() &&
        clientNameController.text.toString().trim().isNotEmpty) {
      seqcuaneClient = seqcuaneClient! + 1;
      await seqRep.incrementSequance("seqClient");

      clientModel = CustomerModel(
        id: seqcuaneClient,
        currncy: selectrtCurrncy!.value,
        date: clientDate,
        name: clientNameController.text.toString().trim(),
        phone: clientPhoneController.text.toString().trim(),
        address: clientAddressController.text.toString().trim(),
        pathImageProfile: pathImageProfileController.text,
        customerTypeId: "client",
        lakom: 0,
        alikom: 0,
        numberTrans: 0,
        notes: notesController.text.isEmpty
            ? " "
            : notesController.text.toString().trim(),
        groupId: " ",
      );

      await customerRep.addCustomer(clientModel!);
      showSnakBarMassageSecc(Get.context!, "تم بنجاح");
      iconErorr != null;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Color(0xFF8E1010),
      //     content: Row(
      //       children: [
      //         Icon(
      //           Iconsax.close_circle,
      //           color: Colors.white,
      //         ),
      //         Text(
      //           " يتم الموافقة",
      //           style: TextStyleTheme.bottonTextStyl,
      //         ),
      //       ],
      //     ),
      //   ),
      // );
      if (clientModel!.currncy == boxMod!.currncyCode) {
        // data[data.length - 1] = clientModel!;
        data.add(clientModel!);
      }

      cleareControllers();
      goToPageClientTransaction(-1, clientModel!.id!);
    } else {
      setIconWorning();
    }

    update();
  }

// add new client end

// get Client on init start
  getClients() async {
    List<CurrencyModel> currncyModle =
        await currncyRep.getAllCurrenciesCustomerType("client");

    for (CurrencyModel currncym in currncyModle) {
      List<CustomerModel> clients =
          await customerRep.getCustomerByCurrencyCode("client", currncym.code!);

      MapClientByCurrncy[currncym.code!] = clients;

      boxM[currncym.code!] =
          await boxRep.getBoxByCustomerTypeCurrncy("client", currncym.code!);
    }

    stateFratechData = true;

    update();
  }
// get Client on init end

  cleareControllers() {
    clientNameController.clear();
    clientPhoneController.clear();
    clientAddressController.clear();
  }

  cleareAllControllers() {
    clientNameController.clear();
    clientPhoneController.clear();
    clientAddressController.clear();
    pathImageProfileController.clear();
    dateTimeController.clear();
  }

  changeSelected() {
    isSelected = !isSelected;
    update();
  }

  addBox(String code, BoxModel bmodel) {
    MapClientByCurrncy[code] = [];
    boxM[code] = bmodel;
    update();
  }

  addInList(CustomerModel cus, String currncyCode) {
    MapClientByCurrncy[currncyCode]!.add(cus);

    update();
  }

// ********************************************** Time and Date Meathodes start *************************************//

// get date and time from celender start
  getDataTimerCelunder(
    BuildContext context,
  ) async {
    Map<String, dynamic> mapDate = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.date, null);

    clientDate = mapDate["date"];
    dateTimeController.text = clientDate!;

    update();
  }
// get date and time from celender end

// on init get date Start
  initDateTime() {
    clientDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    dateTimeController.text = "$clientDate ";
    update();
  }

// on init get date end
// get date from celender only start
  Future<String> getDataTimerCelunderDateOnlyFromDate(
      BuildContext context, DateTime? initialDate) async {
    Map<String, dynamic> mapDate = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.date, initialDate);

    return mapDate["date"];
  }
// get date from celender only end

// from date start report START
  fromDateReport(
    BuildContext context,
  ) async {
    fromDateController.text = await getDataTimerCelunderDateOnlyFromDate(
        context, parseDate(fromDateController.text));
    update();
  }
// from date init report END
// To date init report Start

  toDateReport(
    BuildContext context,
  ) async {
    toDateConstroller.text = await getDataTimerCelunderDateOnlyFromDate(
        context, parseDate(toDateConstroller.text));
    update();
  }

// To date init report end
// ********************************************** Time and Date Meathodes end *************************************//

// ************meathodes of  image Picketure start*****************  //

  getPicker(BuildContext context) async {
    final XFile? image = await showImageSourceBottomSheet(context);
    if (image != null) {
      pathImageProfileController.text = image.path;
      fileProfileImageClient = File(image.path);

      update();
    }
  }
// ************meathodes of  image Picketure end*****************  //

// ************meathodes of class Cntroller start*****************  //
  @override
  onInit() async {
    super.onInit();
    st = false;

    await getCurrncy2();
    await getItem(selectee, crncList.first);

    st = true;
  }

  @override
  void onClose() {
    super.onClose();
    clientNameController.dispose();
    toDateConstroller.dispose();
    notesController.dispose();
    currncyController.dispose();
    searchController.dispose();
    dateTimeController.dispose();
    clientAddressController.dispose();
    clientNameController.dispose();
    clientPhoneController.dispose();
  }
// ************meathodes of class Cntroller end*****************  //

// **************************************************All Meathodes end****************************************************************//
// }

  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];

// @override
// void initState() {
//   super.initState();
//   loadContacts();
// }

  Future<void> loadContacts() async {
    stateContact = false;
    update();
    if (await FlutterContacts.requestPermission()) {
      final allContacts = await FlutterContacts.getContacts(
        withProperties: true,
        // withPhoto: true,
      );

      contacts = allContacts;
      filteredContacts = allContacts;
      Get.to(LoadContactScreen());
    } else {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Color(0xFF8E1010),
      //     content: Text(
      //       "لم يتم الموافقه",
      //       style: TextStyleTheme.bottonTextStyl,
      //     ),
      //   ),
      // );
      showSnakBarMassageError(Get.context!, "لم يتم الموافقة");
    }

    stateContact = true;
    update();
  }

  void filterContacts(String query) {
    final lowerQuery = query.toLowerCase();

    final results = contacts.where((c) {
      final name = c.displayName.toLowerCase();
      final hasName = name.contains(lowerQuery);

      // تحقق من الأرقام
      final hasNumber = c.phones.any((p) => p.number.contains(query));

      return hasName || hasNumber;
    }).toList();
    filteredContacts = results;
    update();
  }
}
