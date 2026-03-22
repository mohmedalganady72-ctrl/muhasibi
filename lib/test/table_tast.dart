import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    if (await FlutterContacts.requestPermission()) {
      final allContacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        contacts = allContacts;
        filteredContacts = allContacts;
      });
    }
  }

  void filterContacts(String query) {
    final lowerQuery = query.toLowerCase();

    final results = contacts.where((c) {
      final name = c.displayName.toLowerCase();
      final hasName = name.contains(lowerQuery);

      // تحقق من الأرقام
      final hasNumber = c.phones.any((p) => p.number.contains(query));

      return hasName || hasNumber;
    }).toList();

    setState(() => filteredContacts = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جهات الاتصال"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterContacts,
              decoration: InputDecoration(
                hintText: "ابحث بالاسم...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ),
      ),
      body: contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return ListTile(
                  leading: (contact.photo != null)
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(contact.photo!))
                      : const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(contact.displayName),
                  subtitle: contact.phones.isNotEmpty
                      ? Text(contact.phones.first.number)
                      : const Text("لا يوجد رقم"),
                  onTap: () {
                    // هنا تقدر تستدعي دالة إرسال واتساب أو SMS
                    final number = contact.phones.isNotEmpty
                        ? contact.phones.first.number
                        : "";
                    Navigator.pop(context, number);
                  },
                );
              },
            ),
    );
  }
}
