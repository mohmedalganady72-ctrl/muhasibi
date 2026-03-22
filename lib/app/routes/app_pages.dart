import 'package:ccount/core/constant/app_page.dart';
import 'package:ccount/test/table_tast.dart';
import 'package:ccount/features/auth/presentation/view/onbordinge.dart';
import 'package:ccount/features/auth/presentation/view/user_profile.dart';
import 'package:ccount/features/debt/presentation/client/view/currncy_screen.dart';
import 'package:ccount/features/debt/presentation/client/view/edite_info_client.dart';
import 'package:ccount/features/debt/presentation/client/view/page_client_transaction.dart';
import 'package:ccount/features/home/presentation/view/home.dart';
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

