import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> sendSMS(String phoneNumber, String message) async {
  final Uri smsUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
    queryParameters: <String, String>{'body': message},
  );

  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    throw 'لا يمكن إرسال الرسالة';
  }
}

Future<void> sendWhatsApp(String phone, String message) async {
  final Uri whatsappUri =
      Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  } else {
    throw 'لا يمكن فتح الواتس اب';
  }
}

void showMessageSheet(
    BuildContext context, String phoneNumber, String message) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Iconsax.sms, color: Colors.blue),
              title: const Text("إرسال رسالة نصية"),
              onTap: () {
                Navigator.pop(context);
                sendSMS(phoneNumber, message);
              },
            ),
            ListTile(
              leading: const Icon(FontAwesome.whatsapp, color: Colors.green),
              title: const Text("إرسال عبر واتساب"),
              onTap: () {
                Navigator.pop(context);
                sendWhatsApp(phoneNumber, message);
              },
            ),
          ],
        ),
      );
    },
  );
}
