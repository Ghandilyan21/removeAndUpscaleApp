import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/domain/repositories/connectivity_repo.dart';

class ConnectivityUsecase {
  final ConectivityRepo conectivityRepo;

  ConnectivityUsecase({required this.conectivityRepo});
  Future<Either<ConectionFailure, bool>> call() async {
    return await conectivityRepo.isConnected;
  }
}