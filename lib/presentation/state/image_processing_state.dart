import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_processing_ai_tool/presentation/state/bg_settings_model.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';


class ImageProcessingState extends Equatable {
  final BgSettingsModel settings;

  const ImageProcessingState({this.settings = const BgSettingsModel()});

  @override
  List<Object?> get props => [settings];
}

// Background remover image picking state
class BgRemoveImagePicking extends ImageProcessingState {}

class BgRemoveImagePicked extends ImageProcessingState {
  final Uint8List? imageBytes;

  const BgRemoveImagePicked({required this.imageBytes});
}

class BgRemoveImagePickFailure extends ImageProcessingState {
  final String message;

  const BgRemoveImagePickFailure({required this.message});
}

//upscale image picking state
class UpscaleImagePicking extends ImageProcessingState {}

class UpscaleImagePicked extends ImageProcessingState {
  final ImageViewModel? imageBytes;

  const UpscaleImagePicked({required this.imageBytes});
}

class UpscaleImagePickFailure extends ImageProcessingState {
  final String message;

  const UpscaleImagePickFailure({required this.message});
}

class UpscaleImageSizePicked extends ImageProcessingState {
  final String size;

  const UpscaleImageSizePicked({required this.size});
}

// remove states
class RemoveBgLoading extends ImageProcessingState {}

class RemoveBgLoaded extends ImageProcessingState {
  final Uint8List? imageBytes;
  String? limit;

  RemoveBgLoaded({required this.imageBytes, this.limit});
}

class RemoveBgLFailure extends ImageProcessingState {
  final String message;

  const RemoveBgLFailure({required this.message});
}

// Bg removed image saving states

class BgRemovedSaving extends ImageProcessingState {}

class BgRemovedSaved extends ImageProcessingState {
  final String message;

  const BgRemovedSaved({required this.message});
}

class BgRemovedSavingFailure extends ImageProcessingState {
  final String message;

  const BgRemovedSavingFailure({required this.message});
  

}

// upscale image states
class UpscaleLoading extends ImageProcessingState {}

class UpscaleLoaded extends ImageProcessingState {
  final ImageViewModel? imageBytes;
  final String upscaledSize;
  final String? limit;

  const UpscaleLoaded({required this.imageBytes, required this.upscaledSize, this.limit});
}

class UpscaleFailure extends ImageProcessingState {
  final String message;

  const UpscaleFailure({required this.message});
}


// upscaled saveing states

class UpscaledSaving extends ImageProcessingState{}

class UpscaledSaved extends ImageProcessingState {
}

class UpscaledSavingFailure extends ImageProcessingState {
  final String message;

  const UpscaledSavingFailure({required this.message});
  

}

// update settings 
class SettingsUpdated extends ImageProcessingState {
  const SettingsUpdated(BgSettingsModel settings) : super(settings: settings);

  @override
  List<Object?> get props => [settings];
}
