import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Shows a bottom sheet to choose image source (gallery or camera) with icons.
Future<XFile?> showImageSourceBottomSheet(BuildContext context) async {
  return showModalBottomSheet<XFile?>(
    context: context,
    builder: (BuildContext ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.of(ctx).pop(
                    await ImagePicker().pickImage(source: ImageSource.gallery));
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.of(ctx).pop(
                    await ImagePicker().pickImage(source: ImageSource.camera));
              },
            ),
          ],
        ),
      );
    },
  );
}
