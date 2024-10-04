

import 'package:image_processing_ai_tool/data/datasources/local/remote/key_validation_check_datasource.dart';
import 'package:image_processing_ai_tool/domain/repositories/login_repository/is_valid_key_repository.dart';

class IsValidKeyRepositoryImpl implements IsValidKeyRepository {
  final KeyValidationCheckDatasource keyValidationCheckDatasource;

  IsValidKeyRepositoryImpl({required this.keyValidationCheckDatasource});
  @override
  Future<bool> isValidKey(String key) async {
    return await keyValidationCheckDatasource.isValidKey(key);
  }
}