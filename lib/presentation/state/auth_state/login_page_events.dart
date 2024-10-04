class AuthEvent {}

class IsValidAPI extends AuthEvent {
  final String key;

  IsValidAPI({required this.key});
}

class CheckUserStatusEvent extends AuthEvent {}

class SaveUserApiKey extends AuthEvent {
  final String key;

  SaveUserApiKey({required this.key});
}
