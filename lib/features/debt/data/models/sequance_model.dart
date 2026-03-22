import 'package:ccount/core/constant/database_table/sequancr_table.dart';

class SequanceModel {
  String? sequanceName;
  int? sequanceNumber;
  int? id;
  SequanceModel({this.id, this.sequanceName, this.sequanceNumber});

  factory SequanceModel.fromJson(Map<String, dynamic> map) {
    return SequanceModel(
        sequanceName: map[seqanceNameTable],
        sequanceNumber: map[seqanceNumber] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      seqId: id,
      seqanceNameTable: sequanceName,
      seqanceNumber: sequanceNumber,
    };
  }
}
