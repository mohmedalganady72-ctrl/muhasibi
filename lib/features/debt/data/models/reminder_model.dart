import 'package:ccount/core/constant/database_table/reminder_table.dart';

class ReminderModel {
  int? id;
  int? customerId;
  String? date;
  String? time;
  String? remarks;
  int? status;

  ReminderModel({
    this.id,
    this.customerId,
    this.date,
    this.time,
    this.remarks,
    this.status,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> map) {
    return ReminderModel(
      id: map[reminderId] ?? 0,
      customerId: map[reminderCustomerIdFkey] ?? 0,
      date: map[reminderDate] ?? '',
      time: map[reminderTime] ?? '',
      remarks: map[reminderRemarks] ?? '',
      status: map[reminderIsCompleted] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      reminderId: id,
      reminderCustomerIdFkey: customerId,
      reminderDate: date,
      reminderTime: time,
      reminderRemarks: remarks,
      reminderIsCompleted: status,
    };
  }
}
