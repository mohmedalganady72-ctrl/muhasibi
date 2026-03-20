import 'package:ccount/core/constant/databaseTable/currencie-table.dart';
import 'package:ccount/data/dataBase/database-helper.dart';
import 'package:ccount/data/model/dbModel/currency-model.dart';
import 'package:sqflite/sqflite.dart';

class CurrencyRepository {
  // create like this class CustomerRepository {
  static Future<List<CurrencyModel>> getAllCurrencies() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(currencyTable);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return CurrencyModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<List<CurrencyModel>> getAllCurrenciesCustomerType(
      String customerT) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(currencyTable,
        where: '$currencyTypeCustomer = ?', whereArgs: [customerT]);

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return CurrencyModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  static Future<List<String>> getCurrencyCodes() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      currencyTable,
    );
    if (result.isEmpty) {
      return [];
    } else {
      return result.map((row) => row[currencyCode] as String).toList();
    }
  }

  Future<CurrencyModel?> getCurrencyById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      currencyTable,
      where: '$currencyId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? CurrencyModel.fromJson(maps.first) : null;
  }

  Future<void> addCurrency(CurrencyModel currency) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      currencyTable,
      currency.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCurrency(CurrencyModel currency) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      currencyTable,
      currency.toJson(),
      where: '$currencyId = ?',
      whereArgs: [currency.id],
    );
  }

  Future<void> deleteCurrency(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      currencyTable,
      where: '$currencyId  = ?',
      whereArgs: [id],
    );
  }
}
