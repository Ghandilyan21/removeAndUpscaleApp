import 'package:flutter/services.dart';
import 'package:image_processing_ai_tool/core/error/image_downloading_error.dart';
import 'package:image_processing_ai_tool/data/datasource_services/image_saving_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';

import 'dart:ui' as ui;

class ImageSaverDatasource {
  final ImageSavingService imageSavingService;

  ImageSaverDatasource({required this.imageSavingService});

  Future<bool> saveBgRemovedImage(Uint8List imageBytes) async {
    PermissionStatus status = await Permission.storage.status;
    if (!(status.isGranted)) {
      status = await Permission.storage.request();
    }
    if (!(status.isGranted)) {
      throw ImageDownloadingError(
          message: "Permission needed for saving image");
    }
    final response = await imageSavingService.saveImage(imageBytes);
    if (response['isSuccess']) {
      return true;
    } else {
      throw ImageDownloadingError(
          message: "Something went wrong while saving image.Please try again!",
          imageBytes: imageBytes);
    }
  }

  Future<bool> saveUpscaledImage(Uint8List imageBytes, String size) async {
    PermissionStatus status = await Permission.storage.status;
    if (!(status.isGranted)) {
      status = await Permission.storage.request();
    }
    if (!(status.isGranted)) {
      throw ImageDownloadingError(
          message: "Permission needed for saving image");
    }

    if (imageBytes.isEmpty) {
      return false;
    }

    final scaleFactor = int.tryParse(size);
    if (scaleFactor == null) {}
    try {
      final ui.ImageDescriptor descriptor = await ui.ImageDescriptor.encoded(
        await ui.ImmutableBuffer.fromUint8List(imageBytes),
      );

      int width = descriptor.width;
      int height = descriptor.height;

      final bytes = await resizeImage(Uint8List.view(imageBytes.buffer),
          width: (width) * ((scaleFactor!)), height: (height) * (scaleFactor));
      if (bytes != null) {
        Uint8List scaledImageData = Uint8List.view(bytes.buffer);
        final response = await imageSavingService.saveImage(scaledImageData);
        if (response['isSuccess']) {
          return true;
        } else {
          throw ImageDownloadingError(
              message:
                  "Something went wrong while saving image.Please try again!",
              imageBytes: imageBytes);
        }
      }
    } catch (e) {
      throw ImageDownloadingError(
          message: "Something went wrong while saving image.Please try again!",
          imageBytes: imageBytes);
    }
    return false;
  }
}
