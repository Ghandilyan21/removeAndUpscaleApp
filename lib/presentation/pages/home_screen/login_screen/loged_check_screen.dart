import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/home_screen.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/login_screen/login_screen.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/auth_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/login_page_events.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/login_page_state.dart';

class LogedCheckScreen extends StatefulWidget {
  const LogedCheckScreen({super.key});

  @override
  State<LogedCheckScreen> createState() => _LogedCheckScreenState();
}

class _LogedCheckScreenState extends State<LogedCheckScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckUserStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoginLoadingState) {

            return const Center(child: CircularProgressIndicator());
          } else if (state is LogedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            });
          } else if (state is NotLogedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
