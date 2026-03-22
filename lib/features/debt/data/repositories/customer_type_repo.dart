import 'package:ccount/core/constant/database_table/customer_type_table.dart';
import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/customer_type_model.dart';
import 'package:sqflite/sqflite.dart';

class CustomerTypeRepository {
  Future<List<CustomerTypeModel>> getAllCustomerTypes() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(customerTypeTable);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return CustomerTypeModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  static Future<List<String>> getAllCustomerName() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(customerTypeTable);
    if (maps.isNotEmpty) {
      return maps.map((row) => row[customerTypeName] as String).toList();
    } else {
      return [];
    }
  }

  Future<CustomerTypeModel?> getCustomerTypeById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      customerTypeTable,
      where: '$customerTypeId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? CustomerTypeModel.fromJson(maps.first) : null;
  }

  static Future<void> addCustomerType(CustomerTypeModel customerType) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      customerTypeTable,
      customerType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCustomerType(CustomerTypeModel customerType) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      customerTypeTable,
      customerType.toJson(),
      where: '$customerTypeId = ?',
      whereArgs: [customerType.id],
    );
  }

  Future<void> deleteCustomerType(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      customerTypeTable,
      where: '$customerTypeId = ?',
      whereArgs: [id],
    );
  }
}

