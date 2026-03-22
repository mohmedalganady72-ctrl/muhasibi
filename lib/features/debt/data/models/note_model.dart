import 'package:ccount/core/constant/database_table/note_table.dart';

class NoteModel {
  int? id;
  int? customerID;
  String? date;
  String? time;
  String? body;

  NoteModel({
    this.id,
    this.customerID,
    this.date,
    this.time,
    this.body,
  });

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      id: map[noteID] ?? 0,
      customerID: map[cusomerId] ?? 0,
      date: map[noteDate] ?? '',
      time: map[noteTime] ?? '',
      body: map[noteBody] ?? '',
    );
  }

  /*
  
    $noteID INTEGER PRIMARY KEY AUTOINCREMENT,
  $cusomerId INTEGER  ,
  $noteDate  TEXT ,
  $noteTime TEXT   ,
  $noteBody TEXT 
  */

  Map<String, dynamic> toJson() {
    return {
      noteID: id,
      cusomerId: customerID,
      noteDate: date,
      noteTime: time,
      noteBody: body,
    };
  }
}
