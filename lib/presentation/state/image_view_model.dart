import 'dart:typed_data';

class ImageViewModel {
  final Uint8List? imageBytes;
  String? limit;

  ImageViewModel({required this.imageBytes, this.limit});

}