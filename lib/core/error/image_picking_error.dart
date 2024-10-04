class Error {}

class ImagePickingError extends Error {
  final String message;

  ImagePickingError({required this.message});
  @override
  String toString() {
    return message;
  }
}