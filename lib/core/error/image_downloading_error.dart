import 'dart:typed_data';

class ImageDownloadingError {
  final String message;

  ImageDownloadingError({required this.message, this.imageBytes});
  late Uint8List? imageBytes;
  @override
  String toString() {
    return message;
  }
}