import 'package:ccount/core/constant/database_table/customer_type_table.dart';

class CustomerTypeModel {
  int? id;
  String name;

  CustomerTypeModel({
    this.id,
    required this.name,
  });

  factory CustomerTypeModel.fromJson(Map<String, dynamic> map) {
    return CustomerTypeModel(
      id: map[customerTypeId] ?? 0,
      name: map[customerTypeName] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      customerTypeId: id,
      customerTypeName: name,
    };
  }
}
