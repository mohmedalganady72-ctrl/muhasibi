import 'package:ccount/core/constant/database_table/box_table.dart';

class BoxModel {
  int? id;
  String? currncyCode;
  num? laho;
  num? alihe;
  String? BTCustomer;

  BoxModel({
    this.id,
    this.currncyCode,
    this.laho,
    this.alihe,
    this.BTCustomer,
  });

  factory BoxModel.fromJson(Map<String, dynamic> map) {
    return BoxModel(
      id: map[boxId],
      currncyCode: map[boxCurrncy],
      laho: map[box_laho],
      alihe: map[box_alihe],
      BTCustomer: map[boxTypeCustomer],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // boxId: id,
      boxCurrncy: currncyCode,
      box_laho: laho,
      box_alihe: alihe,
      boxTypeCustomer: BTCustomer,
    };
  }
}
