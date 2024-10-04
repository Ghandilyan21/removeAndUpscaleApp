import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/domain/usecases/connectivity.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_event.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_state.dart';

class NetworkCheckingBloc extends Bloc<NetworkCheckingEvent, NetworkCheckingState> {
  final ConnectivityUsecase connectivityUsecase;

  NetworkCheckingBloc({ required this.connectivityUsecase}) : super(NetworkCheckingState()) {
    on<CheckConnectivity>((event, emit) async {
      emit(ConnectivityLoading());
      final response = await connectivityUsecase();
      response.fold(
          (failure) => emit(ConnectivityDisconnected(message: failure.message)),
          (success) => emit(ConnectivityConnected()));
    });
  }
}