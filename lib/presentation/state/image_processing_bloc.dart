import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/domain/usecases/bg_removed_image_save_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/remove_bg_pick_image_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/remove_bg_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/upscale_image_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/upscaled_image_save_usecase.dart';
import 'package:image_processing_ai_tool/presentation/state/bg_settings_model.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_event.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_state.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class ImageProcessingBloc
    extends Bloc<ImageProcessingEvent, ImageProcessingState> {
  BgSettingsModel currentSettings = const BgSettingsModel();
  final RemoveBgPickImageUsecase removeBgPickImageUsecase;
  late ImageViewModel imageViewModel;
  final RemoveBgUsecase removeBgUsecase;
  final BgRemovedImageSaveUsecase bgRemovedImageSaveUsecase;
  final UpscaleImageUsecase upscaleImageUsecase;
  final UpscaledImageSaveUsecase upscaledImageSaveUsecase;
  ImageProcessingBloc(
      {required this.upscaleImageUsecase,
      required this.bgRemovedImageSaveUsecase,
      required this.removeBgUsecase,
      required this.removeBgPickImageUsecase,
      required this.upscaledImageSaveUsecase})
      : super(const ImageProcessingState()) {
    on<PickRemoveBgImage>((event, emit) async {
      emit(BgRemoveImagePicking());

      final response = await removeBgPickImageUsecase();
      response.fold(
          (failure) => emit(BgRemoveImagePickFailure(message: failure.message)),
          (image) => emit(BgRemoveImagePicked(imageBytes: image.imageBytes)));
    });

    on<PickUpsclaeImage>((event, emit) async {
      emit(UpscaleImagePicking());

      final response = await removeBgPickImageUsecase();
      response.fold(
          (failure) => emit(UpscaleImagePickFailure(message: failure.message)),
          (image) => emit(UpscaleImagePicked(imageBytes: image)));
    });

    on<ChoseUpscaleSize>((event, emit) async {
      emit(UpscaleImageSizePicked(size: event.size!));
    });

    on<RemoveBgEvent>((event, emit) async {
      emit(RemoveBgLoading());
      final response = await removeBgUsecase(event.viewModel, event.bgSettingsModel);
      response.fold(
          (failure) => emit(RemoveBgLFailure(message: failure.message)),
          (image) => emit(RemoveBgLoaded(imageBytes: image.imageBytes, limit: image.limit)));
    });

    on<SaveBgRemovedImage>((event, emit) async {
      emit(BgRemovedSaving());
      final response = await bgRemovedImageSaveUsecase(event.imageBytes!);
      response.fold((failure) {
        emit(BgRemovedSavingFailure(message: failure.message));
      }, (image) {
        emit(const BgRemovedSaved(message: "Image saved!"));
      });
    });

    on<UpscaleImageEvent>((event, emit) async {
      emit(UpscaleLoading());
      final response = await upscaleImageUsecase(event.imageBytes, event.size);
      response.fold(
          (failure) => emit(UpscaleFailure(message: failure.message)),
          (image) =>
              emit(UpscaleLoaded(imageBytes: image, upscaledSize: event.size, limit: image.limit)));
    });

    on<SaveUpscaledImage>((event, emit) async {
      emit(UpscaledSaving());

      final response =
          await upscaledImageSaveUsecase(event.imageBytes!, event.size);
      response.fold((failure) {
        emit(BgRemovedSavingFailure(message: failure.message));
      }, (image) {
        emit(const BgRemovedSaved(message: "Upscaled image saved!"));
      });
    });

    on<UpdateBgSettings>((event, emit) async {
      print(currentSettings);
      currentSettings = event.settings;
      print(currentSettings);
    // emit(SettingsUpdated(currentSettings));
    });
  }
}
