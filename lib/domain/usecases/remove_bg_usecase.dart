import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class RemoveBgUsecase {
  final ImageProcessingRepo imageProcessingRepo;

  RemoveBgUsecase({required this.imageProcessingRepo}); 
  Future<Either<Failur, ImageViewModel >> call(Uint8List image) async {
    final response = await imageProcessingRepo.removeBg(image);
    return response.fold(
        (failure) => Left(RemoveBgFailure(message: failure.message)),
        (imageEntity) => Right(imageEntity.toViewModel()));
  }
}