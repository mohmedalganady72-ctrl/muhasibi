import 'package:ccount/core/constant/databaseTable/transaction-table.dart';
import 'package:ccount/data/dataBase/database-helper.dart';
import 'package:ccount/data/model/dbModel/transcation-model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(transactionTable);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return TransactionModel.fromJison(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<List<TransactionModel>> getAllTransactionsByIdClient(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      transactionTable,
      where: '$transactionCustomerId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return TransactionModel.fromJison(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<TransactionModel?> getTransactionById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      transactionTable,
      where: '$transactionId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? TransactionModel.fromJison(maps.first) : null;
  }

  Future<List<TransactionModel>> getTransactionByIdCustomer(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      transactionTable,
      where: '$transactionCustomerId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return TransactionModel.fromJison(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      transactionTable,
      transaction.toJison(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      transactionTable,
      transaction.toJison(),
      where: '$transactionId = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> deleteTransaction(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      transactionTable,
      where: '$transactionId = ?',
      whereArgs: [id],
    );
  }
}
