import 'dart:typed_data';

class ImageDTO {
  final Uint8List? imageBytes;
  String? limit;

  ImageDTO({required this.imageBytes, this.limit, });
}
