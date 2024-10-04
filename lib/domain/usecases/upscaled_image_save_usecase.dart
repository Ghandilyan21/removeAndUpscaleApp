import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';

class UpscaledImageSaveUsecase {
  final ImageProcessingRepo imageProcessingRepo;

  UpscaledImageSaveUsecase({required this.imageProcessingRepo});
  Future<Either<ImageSaveingFailure, bool>> call(Uint8List imageBytes, String size) async {
    final response = await imageProcessingRepo.saveUpscaledImage(imageBytes, size);
    return response.fold(
        (failure) => Left(ImageSaveingFailure(message: failure.message)),
        (imagesaved) => const Right(true));
  }
}