import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> getImageUri(String imagePath) async {
    final imageUrl = await Helpers.globalErrorHandler(
      () async {
        final storageRef = FirebaseStorage.instance.ref(imagePath);
        return await storageRef.getDownloadURL();
      },
    );
    return imageUrl ?? "";
  }
}
