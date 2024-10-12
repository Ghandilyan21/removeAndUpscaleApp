import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/domain/usecases/login_usecases/check_user_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/login_usecases/is_valid_api_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/login_usecases/save_api_key_usecase.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/login_page_events.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/login_page_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckUserUsecase checkUserStatus;
  final SaveApiKeyUsecase saveApiKeyUsecase;
  final IsValidApiUsecase isValidApiUsecase;
  AuthBloc({
    required this.checkUserStatus,
    required this.saveApiKeyUsecase,
    required this.isValidApiUsecase,
  }) : super(LoginLoadingState()) {
    on<CheckUserStatusEvent>((event, emit) async {
      final apiKey = await checkUserStatus();
      if (apiKey != null) {
        emit(LogedState());
      } else {
        emit(NotLogedState());
      }
    });

    on<IsValidAPI>((event, emit) async {
      emit(IsValidApiStateChecking());
      bool response = await isValidApiUsecase(event.key);  
      if (response) {
        saveApiKeyUsecase(event.key);
        emit(IsValidApiState());
      } else {
        emit(NotValidApiState());
      }
    });
  }
}
