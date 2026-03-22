import 'package:ccount/core/constant/database_table/sequancr_table.dart';
import 'package:ccount/core/constant/database_table/sequancr_table.dart';
import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/sequance_model.dart';
import 'package:sqflite/sqflite.dart';

class SequanceRepo {
  Future<List<SequanceModel>> getAllSequance() async {
    final db = await DatabaseHelper.instance.database;

    var map = await db.query(
      seqanceTableName,
    );
    if (map.isNotEmpty) {
      return List.generate(map.length, (i) {
        return SequanceModel.fromJson(map[i]);
      });
    } else {
      return [];
    }
  }

  Future<void> addSequance(SequanceModel sModel) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      seqanceTableName,
      sModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletSequance(SequanceModel sModel) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      seqanceTableName,
      where: '$seqanceNameTable = ?',
      whereArgs: [sModel.sequanceName],
    );
  }

  Future<void> incrementSequance(
    String sequanceName, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $seqanceTableName 
    SET $seqanceNumber = $seqanceNumber + 1 
    WHERE $seqanceNameTable = ?
    ''',
      [sequanceName],
    );
  }

  // Future<void> update(SequanceModel sModel) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.update(
  //     seqanceTableName,
  //     sModel.toJson(),
  //     where: '$seqanceNameTable = ?',
  //     whereArgs: [sModel.sequanceName],
  //   );
  // }

  Future<SequanceModel?> getSequanceByName(String name) async {
    final db = await DatabaseHelper.instance.database;

    var map = await db.query(seqanceTableName,
        where: '$seqanceNameTable = ?', whereArgs: [name]);
    if (map.isNotEmpty) {
      // return List.generate(map.length, (i) {

      return SequanceModel.fromJson(map.first);
    } else {
      return SequanceModel();
    }
  }
}

