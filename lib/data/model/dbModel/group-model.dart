import 'package:ccount/core/constant/databaseTable/group-table.dart';

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
