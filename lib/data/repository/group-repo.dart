import 'package:ccount/core/constant/databaseTable/group-table.dart';
import 'package:ccount/data/dataBase/database-helper.dart';
import 'package:ccount/data/model/dbModel/group-model.dart';
import 'package:sqflite/sqflite.dart';

class GroupRepository {
  Future<List<GroupModel>> getAllGroups() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(customerGroupTable);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return GroupModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<GroupModel?> getGroupById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      customerGroupTable,
      where: '$customerGroupIdPrimary = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? GroupModel.fromJson(maps.first) : null;
  }

  Future<void> addGroup(GroupModel group) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      customerGroupTable,
      group.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateGroup(GroupModel group) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      customerGroupTable,
      group.toJson(),
      where: '$customerGroupIdPrimary = ?',
      whereArgs: [group.id],
    );
  }

  Future<void> deleteGroup(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      customerGroupTable,
      where: '$customerGroupIdPrimary = ?',
      whereArgs: [id],
    );
  }
}
