class Failur {
  final String message;

  Failur({required this.message});
}

class ConectionFailure extends Failur {
  @override
  final String message;

  ConectionFailure({required this.message}) : super(message: message);
}

class ImagePickingFailure extends Failur {
  @override
  final String message;

  ImagePickingFailure({required this.message}) : super(message: message);
}

class RemoveBgFailure extends Failur {
  @override
  final String message;

  RemoveBgFailure({required this.message}) : super(message: message);
}

class ImageSaveingFailure extends Failur {
  @override
  final String message;

  ImageSaveingFailure({required this.message}) : super(message: message);
}

class ServerFailure extends Failur {
  @override
  final String message;

  ServerFailure({required this.message}) : super(message: message);
}

class NetworkFailure extends Failur {
  @override
  final String message;

  NetworkFailure({required this.message}) : super(message: message);
}

class ApiPaymentLimitFailur extends Failur {
  @override
  final String message;

  ApiPaymentLimitFailur({required this.message}) : super(message: message);
}

class UpscaleFailur extends Failur {
  @override
  final String message;
  UpscaleFailur({required this.message}) : super(message: message);
}
