import 'package:image_processing_ai_tool/domain/repositories/login_repository/key_save_repository.dart';

class SaveApiKeyUsecase {
  final KeySaveRepository keySaveRepository;
  SaveApiKeyUsecase({required this.keySaveRepository});
  void call(String key) async {
    keySaveRepository.saveUserKey(key);
  }
}