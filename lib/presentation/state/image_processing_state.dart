import 'dart:typed_data';

import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class ImageProcessingState {}

// Background remover image picking state
class BgRemoveImagePicking extends ImageProcessingState {}

class BgRemoveImagePicked extends ImageProcessingState {
  final Uint8List? imageBytes;

  BgRemoveImagePicked({required this.imageBytes});
}

class BgRemoveImagePickFailure extends ImageProcessingState {
  final String message;

  BgRemoveImagePickFailure({required this.message});
}

//upscale image picking state
class UpscaleImagePicking extends ImageProcessingState {}

class UpscaleImagePicked extends ImageProcessingState {
  final ImageViewModel? imageBytes;

  UpscaleImagePicked({required this.imageBytes});
}

class UpscaleImagePickFailure extends ImageProcessingState {
  final String message;

  UpscaleImagePickFailure({required this.message});
}

class UpscaleImageSizePicked extends ImageProcessingState {
  final String size;

  UpscaleImageSizePicked({required this.size});
}

// remove states
class RemoveBgLoading extends ImageProcessingState {}

class RemoveBgLoaded extends ImageProcessingState {
  final Uint8List? imageBytes;

  RemoveBgLoaded({required this.imageBytes});
}

class RemoveBgLFailure extends ImageProcessingState {
  final String message;

  RemoveBgLFailure({required this.message});
}

// Bg removed image saving states

class BgRemovedSaving extends ImageProcessingState {}

class BgRemovedSaved extends ImageProcessingState {
  final String message;

  BgRemovedSaved({required this.message});
}

class BgRemovedSavingFailure extends ImageProcessingState {
  final String message;

  BgRemovedSavingFailure({required this.message});
  

}

// upscale image states
class UpscaleLoading extends ImageProcessingState {}

class UpscaleLoaded extends ImageProcessingState {
  final ImageViewModel? imageBytes;
  final String upscaledSize;

  UpscaleLoaded({required this.imageBytes, required this.upscaledSize});
}

class UpscaleFailure extends ImageProcessingState {
  final String message;

  UpscaleFailure({required this.message});
}


// upscaled saveing states

class UpscaledSaving extends ImageProcessingState{}

class UpscaledSaved extends ImageProcessingState {
}

class UpscaledSavingFailure extends ImageProcessingState {
  final String message;

  UpscaledSavingFailure({required this.message});
  

}