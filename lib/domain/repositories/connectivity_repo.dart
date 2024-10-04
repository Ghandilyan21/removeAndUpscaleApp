import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';

abstract class ConectivityRepo {
  Future<Either<ConectionFailure, bool>> get isConnected;
}