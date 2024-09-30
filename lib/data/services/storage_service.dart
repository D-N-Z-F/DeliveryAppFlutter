import 'dart:io';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  static Future<String?> uploadImage(XFile imageFile) async {
    final imageUrl = await Helpers.globalErrorHandler(
      () async {
        final fileName =
            "restaurantImages/${DateTime.now().millisecondsSinceEpoch}.jpg";
        final storageRef = FirebaseStorage.instance.ref().child(fileName);
        final snapshot = await storageRef.putFile(File(imageFile.path));
        return await snapshot.ref.getDownloadURL();
      },
    );
    return imageUrl;
  }
}
