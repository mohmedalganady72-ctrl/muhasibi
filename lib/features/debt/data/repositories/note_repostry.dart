import 'package:ccount/core/constant/database_table/customer_table.dart';
import 'package:ccount/core/constant/database_table/note_table.dart';

import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/customer_model.dart';
import 'package:ccount/features/debt/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepostry {
  Future<List<NoteModel>> getAllNote() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(noteTableName);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (i) {
          return NoteModel.fromJson(maps[i]);
        },
      );
    } else {
      return [];
    }
  }

  Future<NoteModel?> getNoteById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      noteTableName,
      where: '$noteID = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? NoteModel.fromJson(maps.first) : null;
  }

  Future<List<NoteModel>> getNoteByIdCustomer(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      noteTableName,
      where: '$cusomerId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (i) {
          return NoteModel.fromJson(maps[i]);
        },
      );
    } else {
      return [];
    }
  }

  // static Future<List<CustomerModel>> getClientByCurrencyCode(
  //     String currencyCode) async {
  //   final db = await DatabaseHelper.instance.database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     customerTabl,
  //     where: '$currencyCustomer = ? AND $customerTypeIdNameF = ?',
  //     whereArgs: [currencyCode, "Client"],
  //   );
  //   if (maps.isNotEmpty) {
  //     return List.generate(maps.length, (i) {
  //       return CustomerModel.fromJison(maps[i]);
  //     });
  //   } else {
  //     return [];
  //   }
  // }

  // Future<List<CustomerModel>> getClientByCurrencyCode(
  //     String currencyCode) async {
  //   final db = await DatabaseHelper.instance.database;

  //   final List<Map<String, dynamic>> maps = await db.query(
  //     customerTabl,
  //     where: '$currencyCustomer = ? AND $customerTypeIdNameF = ?',
  //     whereArgs: [currencyCode, "client"],
  //   );

  //   if (maps.isNotEmpty) {
  //     return List.generate(maps.length, (i) {
  //       return CustomerModel.fromJison(maps[i]);
  //     });
  //   } else {
  //     return [];
  //   }
  // }

  // Future<void> addCustomerPayables(int id, num payables) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.rawUpdate(
  //     '''
  //   UPDATE $customerTabl
  //   SET $customerPayables = $customerPayables + $payables , $customerNumberTrans = $customerNumberTrans +1
  //   WHERE $customerId = ?
  //   ''',
  //     [id],
  //   );
  // }

  Future<void> updateNote(NoteModel note) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      noteTableName,
      note.toJson(),
      where: '$noteID = ?',
      whereArgs: [note.id],
    );
  }

  // Future<void> addCustomerReceivables(int id, num receivables) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.rawUpdate(
  //     '''
  //   UPDATE $customerTabl
  //   SET $customerReceivables = $customerReceivables + $receivables , $customerNumberTrans = $customerNumberTrans +1
  //   WHERE $customerId = ?
  //   ''',
  //     [id],
  //   );
  // }

  // Future<CustomerModel?> getSupplierByCurrencyCode(String currencyCode) async {
  //   final db = await DatabaseHelper.instance.database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     customerTabl,
  //     where: '$currencyCustomer = ? AND $customerTypeIdNameF = ?',
  //     whereArgs: [currencyCode, "supplier"],
  //   );
  //   return maps.isNotEmpty ? CustomerModel.fromJison(maps.first) : null;
  // }

  Future<void> addNote(NoteModel note) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      noteTableName,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Future<void> addCraditCustomer(int id, double cradit, int numTran) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.update(
  //     customerTabl,
  //     {'$customerReceivables': cradit, '$customerNumberTrans': numTran},
  //     where: '$customerId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<void> adddDibaditCustomer(int id, double dibad, int numTran) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.update(
  //     customerTabl,
  //     {'$customerPayables': dibad, '$customerNumberTrans': numTran},
  //     where: '$customerId = ?',
  //     whereArgs: [id],
  //   );
  // }

  Future<void> deleteNote(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      noteTableName,
      where: '$noteID = ?',
      whereArgs: [id],
    );
  }
}

