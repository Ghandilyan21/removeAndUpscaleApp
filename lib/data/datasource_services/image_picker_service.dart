import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:image_processing_ai_tool/core/error/image_picking_error.dart';

class ImagePickerService {
  final imagePicker = ImagePicker();
  Future<Uint8List?> pickImage() async {
    try {
      final result = await imagePicker.pickImage(source: ImageSource.gallery);
      return  result!.readAsBytes();
    } catch (e) {
      throw ImagePickingError(message: "Please pick one image to process");
    }
  }
}
