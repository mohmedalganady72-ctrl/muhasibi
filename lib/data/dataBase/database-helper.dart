import 'dart:async';
import 'package:ccount/data/dataBase/database-indexes.dart';
import 'package:ccount/data/dataBase/database-schema.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('hesabak.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB, // دالة الإنشاء التي سيتم استدعاؤها مرة واحدة فقط
      onConfigure: _onConfigure, // دالة التكوين لتفعيل الميزات مثل Foreign Keys
    );
  }

  /// تفعيل القيود المرجعية (Foreign Keys)
  /// خطوة ضرورية لضمان عمل العلاقات بين الجداول بشكل صحيح
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

//   /// تستخدم Batch لتنفيذ جميع الأوامر دفعة واحدة لتحسين الأداء
  Future<void> _createDB(Database db, int version) async {
    final batch = db.batch();

    // -- 1. إنشاء الجداول الرئيسية (التي لا تعتمد على جداول أخرى) --
    // batch.execute(DatabaseSchema.createCustomerGroupsTable);
    batch.execute(DatabaseSchema.createCustomerTypesTable);
    batch.execute(DatabaseSchema.createCurrenciesTable);
    batch.execute(DatabaseSchema.createBox);

    // -- 2. إنشاء الجداول التابعة (التي تحتوي على Foreign Keys) --
    batch.execute(DatabaseSchema.createCustomersTable);
    batch.execute(DatabaseSchema.createTransactionsTable);
    batch.execute(DatabaseSchema.createSequancTabl);
    batch.execute(DatabaseSchema.noteTable);

    // batch.execute(DatabaseSchema.createRemindersTable);

//     // -- 3. إنشاء الفهارس لتحسين سرعة البحث --
//     // (يجب وضع تعريف هذا الكلاس في ملف database_schema.dart)
    for (final command in DatabaseIndexes.commands) {
      batch.execute(command);
    }

//     // تنفيذ جميع الأوامر التي تمت إضافتها إلى الـ Batch
    await batch.commit(noResult: true);
  }
}
