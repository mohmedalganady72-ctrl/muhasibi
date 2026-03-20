import "package:ccount/core/constant/databaseTable/currencie-table.dart";
import "package:ccount/core/constant/databaseTable/customer-table.dart";
import "package:ccount/core/constant/databaseTable/customer-type-table.dart";
import "package:ccount/core/constant/databaseTable/group-table.dart";
import "package:ccount/core/constant/databaseTable/note-table.dart";
import "package:ccount/core/constant/databaseTable/reminder-table.dart";
import "package:ccount/core/constant/databaseTable/sequancr-table.dart";
import "package:ccount/core/constant/databaseTable/transaction-table.dart";
import "package:ccount/core/constant/databaseTable/box-table.dart";

class DatabaseSchema {
  /// جدول العملاء (customers)
  ///
  ///AUTOINCREMENT
  /// يخزن المعلومات الأساسية لكل عميل يتعامل معه النظام.
  static String createCustomersTable = '''
    CREATE TABLE $customerTabl (
      $customerId INTEGER PRIMARY KEY , 
      $customerName TEXT ,            
      $currencyCustomer TEXT ,
      $customerAddress TEXT,  
      $customerDate Date,  
  
      $pathProfileImage TEXT,
      $customerNumberTrans INTEGER DEFAULT 0,
     $customerLakom NUMERIC DEFAULT 0 ,
     $customerAlikom NUMERIC DEFAULT 0 ,
     $customerPhone TEXT ,
                     
      $customerGroupNameF TEXT  ,
      $customerTypeIdNameF TEXT , 
      $customerNote TEXT                         
    
    )
  ''';

  static String createBox = '''
CREATE TABLE $boxTable (
  $boxId INTEGER PRIMARY KEY AUTOINCREMENT,
  $boxCurrncy TEXT  ,
  $box_laho NUMERIC DEFAULT 0,
  $box_alihe NUMERIC DEFAULT 0 ,
  $boxTypeCustomer TEXT 

)
''';

  static String noteTable = '''
CREATE TABLE $noteTableName (
  $noteID INTEGER PRIMARY KEY AUTOINCREMENT,
  $cusomerId INTEGER  ,
  $noteDate  TEXT ,
  $noteTime TEXT   ,
  $noteBody TEXT 

)
''';
// static String createBox = '''
// CREATE TABLE $boxTable (
//   $boxId INTEGER PRIMARY KEY AUTOINCREMENT,
//   $boxCurrncy TEXT UNIQUE NOT NULL,
//   $box_laho TEXT,
//   $box_alihe TEXT NOT NULL,
// --  $boxUpdatedAt TEXT NOT NULL
// )
// ```;

  /// جدول الحركات المالية (transactions)
  /// يسجل كل معاملة مالية تتم في النظام، ويعتبر القلب المالي للتطبيق.
  static const String createTransactionsTable = '''
    CREATE TABLE $transactionTable (
      $transactionId INTEGER PRIMARY KEY AUTOINCREMENT, -- المعرّف الفريد للحركة
      $transactionCustomerId INTEGER , -- يربط الحركة بالعميل صاحب العلاقة
      $transactionAlikom NUMERIC DEFAULT 0,              -- المبلغ الدائن (المبلغ الذي له العميل)
      $transactionLakom NUMERIC DEFAULT 0,               -- المبلغ المدين (المبلغ الذي على العميل)
     
      $transactionDateUser TEXT,          -- تاريخ حدوث المعاملة الفعلية (مثلاً: تاريخ الفاتورة)
      $transactionTimeUser TEXT,          -- تاريخ حدوث المعاملة الفعلية (مثلاً: تاريخ الفاتورة)
      $transactionRemarks TEXT,                          -- ملاحظات إضافية حول الحركة (مثل: دفعة تحت الحساب)
      $transactionCreatedAt TEXT  DEFAULT (datetime('now','localtime')),             -- الطابع الزمني لتاريخ ووقت إنشاء هذا السجل في قاعدة البيانات
      $transactionTransferCustomerId INTEGER , -- معرّف العميل المحوّل إليه (فقط في عمليات التحويل بين حسابين)
      $transactionCurrencyCode TEXT  -- يربط الحركة بعملتها من جدول العملات
    --  "is_online" INTEGER DEFAULT 1,           -- علامة لتحديد ما إذا كانت الحركة تمت عبر الإنترنت (1 = نعم, 0 = لا)
   --   "online_ref" TEXT                        -- الرقم المرجعي للعملية التي تمت عبر الإنترنت
    )
  ''';

  static const String createSequancTabl = '''

 CREATE TABLE $seqanceTableName (
 $seqId INTEGER PRIMARY KEY AUTOINCREMENT ,
      $seqanceNameTable TEXT   , 
      $seqanceNumber INTEGER DEFAULT 0           
              
    )
''';

  static const String createCurrenciesTable = '''
    CREATE TABLE $currencyTable (
      $currencyId INTEGER PRIMARY KEY AUTOINCREMENT, -- المعرّف الفريد للعملة
      $currencyName TEXT    ,           -- اسم العملة (مثال: 'USD', 'YER')
      $currencyCode TEXT ,
      $currencyTypeCustomer TEXT             -- اسم العملة (مثال: 'USD', 'YER')
    )
  ''';

  static const String createCustomerGroupsTable = '''
    CREATE TABLE $customerGroupTable (
      $customerGroupIdPrimary INTEGER PRIMARY KEY AUTOINCREMENT, 
      $customerGroupName TEXT UNIQUE NOT NULL              
    )
  ''';

  static const String createCustomerTypesTable = '''
    CREATE TABLE $customerTypeTable (
      $customerTypeId INTEGER PRIMARY KEY AUTOINCREMENT,            
      $customerTypeName TEXT               
    )
  ''';

  static const String createRemindersTable = '''
    CREATE TABLE $reminderTable (
      $reminderId INTEGER PRIMARY KEY AUTOINCREMENT, -- المعرّف الفريد للتذكير
      $reminderCustomerIdFkey INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE, -- يربط التذكير بعميل معين
      $reminderDate TEXT NOT NULL,           -- تاريخ استحقاق التذكير
      $reminderTime TEXT,                    -- وقت استحقاق التذكير (اختياري)
      $reminderRemarks TEXT NOT NULL,                 -- نص ومحتوى التذكير
      $reminderIsCompleted INTEGER NOT NULL DEFAULT 0 -- علامة لتحديد ما إذا كان قد تم التعامل مع التذكير (1 = نعم, 0 = لا)
    )
  ''';
}
