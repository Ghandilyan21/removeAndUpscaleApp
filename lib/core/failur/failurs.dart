class Failur {
  final String message;

  Failur({required this.message});
}

class ConectionFailure extends Failur {
  final String message;

  ConectionFailure({required this.message}) : super(message: message);
}

class ImagePickingFailure extends Failur {
  final String message;

  ImagePickingFailure({required this.message}) : super(message: message);
}

class RemoveBgFailure extends Failur {
  final String message;

  RemoveBgFailure({required this.message}) : super(message: message);
}

class ImageSaveingFailure extends Failur {
  final String message;

  ImageSaveingFailure({required this.message}) : super(message: message);
}

class ServerFailure extends Failur {
  final String message;

  ServerFailure({required this.message}) : super(message: message);
}

class NetworkFailure extends Failur {
  final String message;

  NetworkFailure({required this.message}) : super(message: message);
}

class ApiPaymentLimitFailur extends Failur {
  final String message;

  ApiPaymentLimitFailur({required this.message}) : super(message: message);
}

class UpscaleFailur extends Failur {
  final String message;
  UpscaleFailur({required this.message}) : super(message: message);
}
