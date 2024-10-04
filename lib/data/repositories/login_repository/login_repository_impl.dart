import 'package:image_processing_ai_tool/data/datasources/local/login_local_datasource.dart';
import 'package:image_processing_ai_tool/domain/repositories/login_repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginLocalDatasource localDatasource;

  LoginRepositoryImpl({required this.localDatasource});
  @override
  Future<String?> checkUserStatus() async {
   return await localDatasource.checkUserStatus();
  }
}