import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/error/api_payment_limit_error.dart';
import 'package:image_processing_ai_tool/core/error/image_downloading_error.dart';
import 'package:image_processing_ai_tool/core/error/network_error.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/data/datasources/local/image_saver_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remote/BgRemover.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remote/upscaler_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remove_bg_image_picker.dart';
import 'package:image_processing_ai_tool/data/datasources/local/upscale_image_picker.dart';
import 'package:image_processing_ai_tool/domain/entities/image_entity.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class ImageProcessingRepoImpl implements ImageProcessingRepo {
  final RemoveBgImagePicker removeBgImagePicker;
  final UpscaleImagePicker upscaleImagePicker;
  final Bgremover bgremover;
  final ImageSaverDatasource imageSaverDatasource;
  final UpscalerDatasource upscalerDatasource;

  ImageProcessingRepoImpl(
      {required this.upscalerDatasource,
      required this.imageSaverDatasource,
      required this.upscaleImagePicker,
      required this.bgremover,
      required this.removeBgImagePicker});
  @override
  Future<Either<ImagePickingFailure, ImageEntity>> pickRemoveBgImage() async {
    try {
      final result = await removeBgImagePicker.removeBgPickImage();
      return Right(ImageEntity.fromDTO(result));
    } catch (e) {
      return Left(ImagePickingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ImagePickingFailure, ImageEntity>> pickUpscaleImage() async {
    try {
      final result = await upscaleImagePicker.upscalePickImage();
      return Right(ImageEntity.fromDTO(result));
    } catch (e) {
      return Left(ImagePickingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failur, ImageEntity>> removeBg(Uint8List image) async {
    try {
      final result = await bgremover.removeBg(image);
      return Right(ImageEntity.fromDTO(result));
    } on NetworkError catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    } on ApiPaymentLimitError catch (e) {
      return Left(ApiPaymentLimitFailur(message: e.toString()));
    } catch (e) {
      return Left(RemoveBgFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ImageSaveingFailure, bool>> saveBgRemovedImage(
      Uint8List imageBytes) async {
    try {
      await imageSaverDatasource.saveBgRemovedImage(imageBytes);
      return const Right(true);
    } on ImageDownloadingError catch (e) {
      return Left(ImageSaveingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failur, ImageEntity>> upscale(ImageViewModel image, String size) async {
     try {
      final result = await upscalerDatasource.upscaleImage(image, size);
      return Right(ImageEntity.fromDTO(result));
    } on NetworkError catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    } on ApiPaymentLimitError catch (e) {
      return Left(ApiPaymentLimitFailur(message: e.toString()));
    } catch (e) {
      return Left(RemoveBgFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<ImageSaveingFailure, bool>> saveUpscaledImage(Uint8List imageBytes, String size) async {
    try {
      await imageSaverDatasource.saveUpscaledImage(imageBytes, size);
      return const Right(true);
    } on ImageDownloadingError catch (e) {
      return Left(ImageSaveingFailure(message: e.toString()));
    }
  }
}
