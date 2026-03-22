import 'package:ccount/features/debt/data/repositories/box_repo.dart';
import 'package:ccount/features/debt/data/repositories/currency_repo.dart';
import 'package:ccount/features/debt/data/repositories/customer_repo.dart';
import 'package:ccount/features/debt/data/repositories/customer_type_repo.dart';
import 'package:ccount/features/debt/data/repositories/group_repo.dart';
import 'package:ccount/features/debt/data/repositories/note_repostry.dart';
import 'package:ccount/features/debt/data/repositories/sequance_repo.dart';
import 'package:ccount/features/debt/data/repositories/transcation_repo.dart';
import 'package:get/get.dart';

class BindingApp extends Bindings {
  @override
  void dependencies() {
    Get.put(SequanceRepo());
    Get.put(NoteRepostry());
    Get.put(CurrencyRepository());
    Get.put(CustomerRepository());
    Get.put(CustomerTypeRepository());
    Get.put(GroupRepository());
    Get.put(BoxRepository());
    Get.put(TransactionRepository());
  }
}

