import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class UpscaleImageUsecase {
  final ImageProcessingRepo imageProcessingRepo;

  UpscaleImageUsecase({required this.imageProcessingRepo});

  Future<Either<Failur, ImageViewModel>> call(
      ImageViewModel image, String size) async {
    final response = await imageProcessingRepo.upscale(image, size);
    return response.fold(
        (failure) => Left(UpscaleFailur(message: failure.message)),
        (imageEntity) => Right(imageEntity.toViewModel()));
  }
}
