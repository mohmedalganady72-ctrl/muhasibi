import 'package:ccount/core/constant/database_table/group_table.dart';

class GroupModel {
  int id;
  String name;

  GroupModel({
    required this.id,
    required this.name,
  });

  factory GroupModel.fromJson(Map<String, dynamic> map) {
    return GroupModel(
      id: map[customerGroupIdPrimary] ?? 0,
      name: map[customerGroupName] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      customerGroupIdPrimary: id,
      customerGroupName: name,
    };
  }
}
