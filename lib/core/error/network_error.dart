class NetworkError {
  final String message;

  NetworkError({required this.message});
  @override
  String toString() {
    return message;
  }
}