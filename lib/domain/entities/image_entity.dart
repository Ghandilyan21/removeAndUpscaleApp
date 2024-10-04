import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_processing_ai_tool/data/DTO/imageDTO.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class ImageEntity extends Equatable {
  final Uint8List? imageBytes;

  const ImageEntity({required this.imageBytes});

  @override
  List<Object?> get props => [imageBytes];

  factory ImageEntity.fromDTO(ImageDTO imagedto) {
    return ImageEntity(imageBytes: imagedto.imageBytes);
  }

  ImageDTO toDTO() {
    return ImageDTO(imageBytes: imageBytes);
  }

  ImageViewModel toViewModel() {
    return ImageViewModel(imageBytes: imageBytes);
  }
}
