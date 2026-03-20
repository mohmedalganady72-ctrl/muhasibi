class DatabaseIndexes {
  static const List<String> commands = [
    /// فهرس لتسريع البحث عن الحركات حسب العميل
    // 'CREATE INDEX IF NOT EXISTS idx_transactions_customer_id ON transactions(customer_id);',

    /// فهرس لتسريع البحث عن العملاء بالاسم
    'CREATE INDEX IF NOT EXISTS idx_customers_name ON customers(name);',

    /// فهرس لتسريع البحث عن العملاء برقم الهاتف
    'CREATE INDEX IF NOT EXISTS idx_customers_phone ON customers(phone);',

    /// فهرس لتسريع جلب المستندات حسب التاريخ
    // 'CREATE INDEX IF NOT EXISTS idx_document_headers_date ON document_headers(document_date);'
  ];
}

// في ملف database_helper.dart داخل دالة _createDB
// بعد إنشاء كل الجداول، أضف هذا الكود:
// for (final command in DatabaseIndexes.commands) {
//   await db.execute(command);
// }