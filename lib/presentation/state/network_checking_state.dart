class NetworkCheckingState {}

// network connectivity states
class ConnectivityLoading extends NetworkCheckingState {}

class ConnectivityConnected extends NetworkCheckingState {}

class ConnectivityDisconnected extends NetworkCheckingState {
  final String message;

  ConnectivityDisconnected({required this.message});
}