import 'package:ccount/core/constant/database_table/customer_table.dart';

import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/customer_model.dart';
import 'package:sqflite/sqflite.dart';

class CustomerRepository {
  Future<List<CustomerModel>> getAllCustomers() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(customerTabl);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (i) {
          return CustomerModel.fromJison(maps[i]);
        },
      );
    } else {
      return [];
    }
  }

  Future<CustomerModel?> getCustomerById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      customerTabl,
      where: '$customerId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? CustomerModel.fromJison(maps.first) : null;
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

  Future<List<CustomerModel>> getCustomerByCurrencyCode(
      String cutomer, String currencyCode) async {
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      customerTabl,
      where: '$currencyCustomer = ? AND $customerTypeIdNameF = ?',
      whereArgs: [currencyCode, "$cutomer"],
    );

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return CustomerModel.fromJison(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<void> addCustomerLakom(
    int id,
    num lakom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $customerTabl 
    SET $customerLakom = $customerLakom + $lakom , $customerNumberTrans = $customerNumberTrans +1 
    WHERE $customerId = ?
    ''',
      [id],
    );
  }

  Future<void> minusCustomerLakom(
    int id,
    num lakom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $customerTabl 
    SET $customerLakom = $customerLakom - $lakom , $customerNumberTrans = $customerNumberTrans +1 
    WHERE $customerId = ?
    ''',
      [id],
    );
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      customerTabl,
      customer.toJison(),
      where: '$customerId = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> addCustomerAlikom(
    int id,
    num alikom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $customerTabl 
    SET $customerAlikom = $customerAlikom + $alikom , $customerNumberTrans = $customerNumberTrans +1 
    WHERE $customerId = ?
    ''',
      [id],
    );
  }

  Future<void> minusCustomerAlikom(
    int id,
    num alikom, {
    DatabaseExecutor? executor,
  }) async {
    final db = executor ?? await DatabaseHelper.instance.database;
    await db.rawUpdate(
      '''
    UPDATE $customerTabl 
    SET $customerAlikom = $customerAlikom - $alikom , $customerNumberTrans = $customerNumberTrans +1 
    WHERE $customerId = ?
    ''',
      [id],
    );
  }

  Future<CustomerModel?> getSupplierByCurrencyCode(String currencyCode) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      customerTabl,
      where: '$currencyCustomer = ? AND $customerTypeIdNameF = ?',
      whereArgs: [currencyCode, "supplier"],
    );
    return maps.isNotEmpty ? CustomerModel.fromJison(maps.first) : null;
  }

  Future<void> addCustomer(CustomerModel customer) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      customerTabl,
      customer.toJison(),
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

  Future<void> deleteCustomer(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      customerTabl,
      where: '$customerId = ?',
      whereArgs: [id],
    );
  }
}

