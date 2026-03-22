import 'package:ccount/core/constant/database_table/reminder_table.dart';
import 'package:ccount/core/database/database_helper.dart';
import 'package:ccount/features/debt/data/models/reminder_model.dart';
import 'package:sqflite/sqflite.dart';

class ReminderRepository {
  Future<List<ReminderModel>> getAllReminders() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      reminderTable,
    );
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return ReminderModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  Future<ReminderModel?> getReminderById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      reminderTable,
      where: '$reminderId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? ReminderModel.fromJson(maps.first) : null;
  }

  Future<void> addReminder(ReminderModel reminder) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      reminderTable,
      reminder.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      reminderTable,
      reminder.toJson(),
      where: '$reminderId = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<void> deleteReminder(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      reminderTable,
      where: '$reminderId = ?',
      whereArgs: [id],
    );
  }
}

