import 'dart:typed_data';

import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';

class ImageProcessingEvent {}

// events for background remover
class PickRemoveBgImage extends ImageProcessingEvent {}

class PickUpsclaeImage extends ImageProcessingEvent {}

class ChoseUpscaleSize extends ImageProcessingEvent {
  final String? size;

  ChoseUpscaleSize({required this.size});
}

class RemoveBgEvent extends ImageProcessingEvent {
  final Uint8List imageBytes;

  RemoveBgEvent({required this.imageBytes});
}

class SaveBgRemovedImage extends ImageProcessingEvent {
  final Uint8List? imageBytes;

  SaveBgRemovedImage({required this.imageBytes});
}


class UpscaleImageEvent extends ImageProcessingEvent{
  final ImageViewModel imageBytes;
  final String size;

  UpscaleImageEvent({required this.imageBytes, required this.size});
}

class SaveUpscaledImage extends ImageProcessingEvent {
  final String size;
  final Uint8List? imageBytes;

  SaveUpscaledImage({required this.imageBytes, required this.size});
}