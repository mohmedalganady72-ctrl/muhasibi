import 'package:ccount/data/repository/box-repo.dart';
import 'package:ccount/data/repository/currency-repo.dart';
import 'package:ccount/data/repository/customer-repo.dart';
import 'package:ccount/data/repository/customer-type-repo.dart';
import 'package:ccount/data/repository/group-repo.dart';
import 'package:ccount/data/repository/note-repostry.dart';
import 'package:ccount/data/repository/sequance-repo.dart';
import 'package:ccount/data/repository/transcation-repo.dart';
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
