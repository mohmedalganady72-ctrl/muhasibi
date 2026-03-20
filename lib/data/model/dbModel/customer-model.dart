import 'package:ccount/core/constant/databaseTable/customer-table.dart';

// class CustomerModel {
//   int? id;
//   String name;
//   String? address;
//   String? phone;
//   String? date;
//   String? time;
//   String? currncy;
//   int? groupId;
//   double? attic;
//   double? for_him;
//   int customerTypeId;
//   String? notes;

//   CustomerModel({
//     this.id,
//     required this.name,
//     this.phone,
//     required this.date,
//     required this.time,
//     required this.currncy,
//     this.attic = 0,
//     this.for_him = 0,
//     this.groupId,
//     this.address,
//     required this.customerTypeId,
//     this.notes,
//   });

// ... existing code ...
class CustomerModel {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? date;
  // String? time;
  String? currncy;
  String? groupId;
  num? lakom;
  num? alikom;
  String? customerTypeId; // تغيير من int إلى String
  String? notes;
  int? numberTrans;
  String? pathImageProfile;

  CustomerModel({
    this.id,
    this.name,
    this.phone,
    this.pathImageProfile,
    this.date,
    // required this.time,
    this.currncy,
    this.lakom = 0,
    this.alikom = 0,
    this.groupId,
    this.address,
    this.numberTrans,
    this.customerTypeId, // تغيير النوع
    this.notes,
  });
// ... existing code ...
  // ... existing code ...
  factory CustomerModel.fromJison(Map<String, dynamic> map) {
    return CustomerModel(
      id: map[customerId], // إضافة ID
      name: map[customerName] ?? '',
      numberTrans: map[customerNumberTrans] ?? 0,
      phone: map[customerPhone] ?? '',
      date: map[customerDate] ?? '',
      // time: map[customerTime] ?? '',
      pathImageProfile: map[pathProfileImage] ?? '',
      address: map[customerAddress] ?? '',
      lakom: map[customerLakom],
      alikom: map[customerAlikom],
      currncy: map[currencyCustomer] ?? '',
      groupId: map[customerGroupNameF] ?? "dfd",
      customerTypeId: map[customerTypeIdNameF] ?? '', // تغيير إلى نص
      notes: map[customerNote] ?? '',
    );
  }

  Map<String, dynamic> toJison() {
    return {
      customerId: id, // إضافة ID
      customerName: name,
      customerNumberTrans: numberTrans,
      customerPhone: phone,
      customerGroupNameF: groupId,
      customerTypeIdNameF: customerTypeId, // سيتم إرسال النص
      currencyCustomer: currncy,
      customerAddress: address,
      pathProfileImage: pathImageProfile,
      customerLakom: lakom,
      customerAlikom: alikom,
      customerDate: date,
      // customerTime: time,
      customerNote: notes,
    };
  }
// ... existing code ...

  // factory CustomerModel.fromJison(Map<String, dynamic> map) {
  //   return CustomerModel(
  //     // id: map[customerId] ?? 0,
  //     name: map[customerName] ?? '',
  //     phone: map[customerPhone] ?? '',
  //     date: map[customerDate] ?? '',
  //     time: map[customerTime] ?? '',
  //     address: map[customerAddress] ?? '',
  //     attic: map['attic'] != null ? (map['attic'] as num).toDouble() : 0.0,
  //     for_him:
  //         map['for_him'] != null ? (map['for_him'] as num).toDouble() : 0.0,
  //     currncy: map[currencyCustomer] ?? '',
  //     groupId: map[customerGroupNameF] ?? 0,
  //     customerTypeId: map[customerTypeIdNameF] ?? 0,
  //     notes: map[customerNote] ?? '',
  //   );
  // }

  // Map<String, dynamic> toJison() {
  //   return {
  //     // customerId: id,
  //     customerName: name,
  //     customerPhone: phone,
  //     customerGroupNameF: groupId,
  //     customerTypeIdNameF: customerTypeId,
  //     currencyCustomer: currncy,
  //     customerAddress: address,
  //     customerDate: date,
  //     customerTime: time,
  //     customerNote: notes,
  //   };
  // }
}
