import 'package:image_processing_ai_tool/data/datasources/local/save_local_key_datasource.dart';
import 'package:image_processing_ai_tool/domain/repositories/login_repository/key_save_repository.dart';

class KeySaveRepositoryImpl implements KeySaveRepository {
  final SaveLocalKeyDatasource saveLocalKeyDatasource;

  KeySaveRepositoryImpl({required this.saveLocalKeyDatasource});
  @override
  void saveUserKey(String key) async {
    saveLocalKeyDatasource.saveUserKey(key);
  }
}