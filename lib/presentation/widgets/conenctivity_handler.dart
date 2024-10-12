import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/login_screen/loged_check_screen.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/login_screen/login_screen.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_event.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_state.dart';

class ConenctivityHandler extends StatelessWidget {
  const ConenctivityHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCheckingBloc, NetworkCheckingState>(
        builder: (context, state){
      if (state is ConnectivityLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ConnectivityConnected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LogedCheckScreen()));
        });
      } else if (state is ConnectivityDisconnected) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Internet Connection',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<NetworkCheckingBloc>(context)
                        .add(CheckConnectivity());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }
      return const Scaffold(
        body: Center(child: Text('Initializing...')),
      );
    });
  }


}
