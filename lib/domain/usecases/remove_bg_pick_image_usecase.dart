import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class RemoveBgPickImageUsecase {
  final ImageProcessingRepo imageProcessingRepo;

  RemoveBgPickImageUsecase({required this.imageProcessingRepo});
  Future<Either<ImagePickingFailure, ImageViewModel>> call() async {
    final response = await imageProcessingRepo.pickRemoveBgImage();
    return response.fold(
        (failure) => Left(ImagePickingFailure(message: failure.message)),
        (imageEntity) => Right(imageEntity.toViewModel()));
  }
}
