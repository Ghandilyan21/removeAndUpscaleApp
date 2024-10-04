import 'package:image_processing_ai_tool/domain/repositories/login_repository/is_valid_key_repository.dart';

class IsValidApiUsecase {
  final IsValidKeyRepository isValidKeyRepository;

  IsValidApiUsecase({required this.isValidKeyRepository});
  Future<bool> call(String key) async {
    return isValidKeyRepository.isValidKey(key);
  }
}