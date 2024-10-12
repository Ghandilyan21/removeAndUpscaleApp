import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_processing_ai_tool/presentation/state/bg_settings_model.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

abstract class ImageProcessingEvent extends Equatable {
  const ImageProcessingEvent();

  @override
  List<Object?> get props => [];
}

// events for background remover
class PickRemoveBgImage extends ImageProcessingEvent {}

class PickUpsclaeImage extends ImageProcessingEvent {}

class ChoseUpscaleSize extends ImageProcessingEvent {
  final String? size;

  const ChoseUpscaleSize({required this.size});
}

class RemoveBgEvent extends ImageProcessingEvent {
  final ImageViewModel viewModel;
  final BgSettingsModel bgSettingsModel;

  const RemoveBgEvent({
    required this.viewModel,
    required this.bgSettingsModel,
  });
}

class SaveBgRemovedImage extends ImageProcessingEvent {
  final Uint8List? imageBytes;

  const SaveBgRemovedImage({required this.imageBytes});
}

class UpscaleImageEvent extends ImageProcessingEvent {
  final ImageViewModel imageBytes;
  final String size;

  const UpscaleImageEvent({required this.imageBytes, required this.size});
}

class SaveUpscaledImage extends ImageProcessingEvent {
  final String size;
  final Uint8List? imageBytes;

  const SaveUpscaledImage({required this.imageBytes, required this.size});
}

class UpdateBgSettings extends ImageProcessingEvent {
  final BgSettingsModel settings;

  const UpdateBgSettings(this.settings);

  @override
  List<Object?> get props => [settings];
}
