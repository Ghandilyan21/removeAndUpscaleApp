import 'package:dartz/dartz.dart';
import 'package:image_processing_ai_tool/core/failur/failurs.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remote/conectivity_checker_datasource.dart';
import 'package:image_processing_ai_tool/domain/repositories/connectivity_repo.dart';

class ConectivityRepoImpl implements ConectivityRepo {
  final ConectivityCheckerDatasource conectivityCheckerDatasource;

  ConectivityRepoImpl({required this.conectivityCheckerDatasource});
  @override
  Future<Either<ConectionFailure, bool>> get isConnected async {
    if (await conectivityCheckerDatasource.isConnected) {
      return const Right(true);
    }
    return Left(ConectionFailure(message: "Failed connect to the internet"));
  }
}