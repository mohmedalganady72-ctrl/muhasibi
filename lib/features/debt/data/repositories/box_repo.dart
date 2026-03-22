import 'package:ccount/core/constant/database_table/box_table.dart';
import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/box_model.dart';
import 'package:sqflite/sqflite.dart';

class BoxRepository {
  //to do:define meathod

  Future<List<BoxModel>> getAllBoxes() async {
    // Implement your logic to retrieve all boxes from the database
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(boxTable);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return BoxModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<void> addCardit(
      String tybeCustomer, String code, double cradit) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      boxTable,
      {
        '$box_laho': cradit,
      },
      where: '$boxCurrncy = ? AND $boxTypeCustomer = ?',
      whereArgs: [code, tybeCustomer],
    );
  }

  // Future<void> addDibited(
  //     String tybeCustomer, String code, double dibit) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.update(
  //     boxTable,
  //     {
  //       '$box_alihe': dibit,
  //     },
  //     where: '$boxCurrncy = ? AND $boxTypeCustomer = ?',
  //     whereArgs: [code, tybeCustomer],
  //   );
  // }

  Future<BoxModel?> getBoxById(int id) async {
    // Implement your logic to retrieve a box by its ID from the database
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      boxTable,
      where: '$boxId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return BoxModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<BoxModel>> getBoxByCustomerType(String customerType) async {
    // Implement your logic to retrieve a box by its currency from the database
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      boxTable,
      where: '$boxTypeCustomer = ?',
      whereArgs: [customerType],
    );
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return BoxModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  // Future<BoxModel> getBoxByCustomerTypeCurrncy(
  //     String customerType, String currncy) async {
  //   // Implement your logic to retrieve a box by its currency from the database
  //   final db = await DatabaseHelper.instance.database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     boxTable,
  //     where: '$boxTypeCustomer = ? AND $boxCurrncy =?',
  //     whereArgs: [customerType, currncy],
  //   );
  //   // if (maps.isNotEmpty) {

  //   return BoxModel.fromJson(maps.first);

  //   // } else {
  //   //   return BoxModel;
  //   // }
  // }

  // Future<void> addBoxLakom(int id, num lakom) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.rawUpdate(
  //     '''
  //   UPDATE $boxTable
  //   SET $box_laho = $box_laho + $lakom
  //   WHERE $boxId = ?
  //   ''',
  //     [id],
  //   );
  // }

  // Future<void> minusBoxLakom(int id, num lakom) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.rawUpdate(
  //     '''
  //   UPDATE $boxTable
  //   SET $box_laho = $box_laho - $lakom
  //   WHERE $boxId = ?
  //   ''',
  //     [id],
  //   );
  // }

  // Future<void> addBoxAlikom(int id, num alikom) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.rawUpdate(
  //     '''
  //   UPDATE $boxTable
  //   SET $box_alihe = $box_alihe + $alikom
  //   WHERE $boxId = ?
  //   ''',
  //     [id],
  //   );
  // }

  Future<void> minusBoxAlikom(
    String customerType,
    String currncy,
    num alikom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $boxTable 
    SET $box_alihe = $box_alihe - $alikom 
    WHERE $boxTypeCustomer = ? AND $boxCurrncy = ?
    ''',
      [customerType, currncy],
    );
  }

  Future<void> minusBoxLakom(
    String customerType,
    String currncy,
    num lakom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $boxTable 
    SET $box_laho = $box_laho - $lakom 
    WHERE $boxTypeCustomer = ? AND $boxCurrncy = ?
    ''',
      [customerType, currncy],
    );
  }

  Future<void> addBoxLakom(
    String customerType,
    String currncy,
    num lakom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $boxTable 
    SET $box_laho = $box_laho + $lakom 
    WHERE $boxTypeCustomer = ? AND $boxCurrncy = ?
    ''',
      [customerType, currncy],
    );
  }

  Future<void> addBoxAlikom(
    String customerType,
    String currncy,
    num alikom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $boxTable 
    SET $box_alihe = $box_alihe + $alikom 
    WHERE $boxTypeCustomer = ? AND $boxCurrncy = ?
    ''',
      [customerType, currncy],
    );
  }

  Future<BoxModel> getBoxByCustomerTypeCurrncy(
      String customerType, String currncy) async {
    final db = await DatabaseHelper.instance.database;

    var maps = await db.query(
      boxTable,
      where: '$boxTypeCustomer = ? AND $boxCurrncy = ?',
      whereArgs: [customerType, currncy],
    );

    if (maps.isNotEmpty) {
      return BoxModel.fromJson(maps.first);
    } else {
      return BoxModel();
    }
  }

  // Future<BoxModel> getBoxByCustomerTypeCurrncy(
  //     String customerType, String currncy) async {
  //   final db = await DatabaseHelper.instance.database;

  //   var maps = await db.query(
  //     boxTable,
  //     where: '$boxTypeCustomer = ? AND $boxCurrncy = ?',
  //     whereArgs: [customerType, currncy],
  //   );

  //   // if (maps.isNotEmpty) {
  //   return BoxModel.fromJson(maps.first);
  //   // } else {
  //   //   return null; // ما في بيانات
  //   // }
  // }

  Future<void> insertBox(BoxModel box) async {
    // Implement your logic to insert a new box into the database
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      boxTable,
      box.toJson(),
      // conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateBox(BoxModel box) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      boxTable,
      box.toJson(),
      where: '$boxId = ?',
      whereArgs: [box.id],
    );
  }

  Future<void> deleteBox(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      boxTable,
      where: '$boxId = ?',
      whereArgs: [id],
    );
  }
}

