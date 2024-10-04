import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/entities/image_entity.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

abstract class ImageProcessingRepo {
  Future<Either<ImagePickingFailure, ImageEntity>> pickRemoveBgImage();
  Future<Either<ImagePickingFailure, ImageEntity>> pickUpscaleImage();
  Future<Either<Failur, ImageEntity>> removeBg(Uint8List image);
  Future<Either<Failur, ImageEntity>> upscale(ImageViewModel image, String size);
  Future<Either<ImageSaveingFailure, bool>> saveBgRemovedImage(Uint8List image);
  Future<Either<ImageSaveingFailure, bool>> saveUpscaledImage(Uint8List image, String size);
}