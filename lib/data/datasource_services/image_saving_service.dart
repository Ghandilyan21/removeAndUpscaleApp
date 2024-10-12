import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSavingService {
  Future<dynamic> saveImage(Uint8List imageBytes) async {
    return await ImageGallerySaver.saveImage(imageBytes, name: "image_${DateTime.now().millisecondsSinceEpoch}", );
  }
}
