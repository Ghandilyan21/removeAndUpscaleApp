import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';

class BgRemovedImageSaveUsecase {
  final ImageProcessingRepo imageProcessingRepo;

  BgRemovedImageSaveUsecase({required this.imageProcessingRepo});
  Future<Either<ImageSaveingFailure, bool>> call(Uint8List imageBytes) async {
    final response = await imageProcessingRepo.saveBgRemovedImage(imageBytes);
    return response.fold(
        (failure) => Left(ImageSaveingFailure(message: failure.message)),
        (imagesaved) => const Right(true));
  }
}