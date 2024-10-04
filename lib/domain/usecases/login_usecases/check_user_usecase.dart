import 'package:image_processing_ai_tool/domain/repositories/login_repository/login_repository.dart';

class CheckUserUsecase {
  final LoginRepository loginRepository;

  CheckUserUsecase({required this.loginRepository});
  Future<String?> call() async {
    return await loginRepository.checkUserStatus();
  }
}



