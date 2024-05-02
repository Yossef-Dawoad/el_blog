import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage([int imageQuality = 90]) async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    if (xFile == null) return null;
    return File(xFile.path);
  } catch (e) {
    return null;
  }
}
