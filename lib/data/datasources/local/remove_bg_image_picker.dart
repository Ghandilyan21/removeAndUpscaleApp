import 'package:image_processing_ai_tool/core/error/image_picking_error.dart';
import 'package:image_processing_ai_tool/data/DTO/imageDTO.dart';
import 'package:image_processing_ai_tool/data/datasource_services/image_picker_service.dart';

class RemoveBgImagePicker {
  final ImagePickerService imagePickerService;

  RemoveBgImagePicker({required this.imagePickerService});

  Future<ImageDTO> removeBgPickImage() async {
    try {
      final result = await imagePickerService.pickImage();
      return ImageDTO(imageBytes: result);
    } catch (e) {
      throw ImagePickingError(message: e.toString());
    }
  }
}
