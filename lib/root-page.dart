import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/test/table-tast.dart';
import 'package:ccount/view/auth/view/onbordinge.dart';
import 'package:ccount/view/auth/view/user-profile.dart';
import 'package:ccount/view/debt/client/view/currncy-screen.dart';
import 'package:ccount/view/debt/client/view/edite-info-client.dart';
import 'package:ccount/view/debt/client/view/page-client-transaction.dart';
import 'package:ccount/view/home/view/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: "/", page: () => const Onbordinge()),
  GetPage(name: AppPage.userProfilePage, page: () => const UserProfile()),
  GetPage(name: AppPage.homePage, page: () => Home()),
  GetPage(name: AppPage.currncyPage, page: () => CurrncyScreen()),
  GetPage(name: AppPage.editeInfoClient, page: () => EditeInfoClient()),
  GetPage(
      name: AppPage.pageClientTransaction, page: () => PageClientTransaction()),
  // name: AppPage.pageClientTransaction, page: () => PageClientTransaction()),
];
