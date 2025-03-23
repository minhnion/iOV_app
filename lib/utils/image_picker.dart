import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerUtils {
  static final ImagePicker _picker = ImagePicker();

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  Future<String?> openCamera({
    BuildContext? context,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      if (!await requestCameraPermission()) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quyền truy cập camera bị từ chối')),
          );
        }
        return null;
      }
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      print('111, ${photo?.path}');
      return photo?.path;
    } catch (e) {
      print('Error capturing image: $e');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể truy cập camera')),
        );
      }
      return null;
    }
  }

  Future<String?> openGalleryForSingleImage({
    BuildContext? context,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      return image?.path;
    } catch (e) {
      print('Error picking image: $e');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể truy cập thư viện ảnh')),
        );
      }
      return null;
    }
  }

  Future<List<String>> openGalleryForMultipleImages({
    BuildContext? context,
    int? imageQuality,
  }) async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        imageQuality: imageQuality,
      );

      if (images != null) {
        return images.map((image) => image.path).toList();
      }
      return [];
    } catch (e) {
      print('Error picking multiple images: $e');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể truy cập thư viện ảnh')),
        );
      }
      return [];
    }
  }
}
