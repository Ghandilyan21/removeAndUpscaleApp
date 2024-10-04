import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/dipendency_injection.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/auth_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_event.dart';
import 'package:image_processing_ai_tool/presentation/widgets/conenctivity_handler.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<NetworkCheckingBloc>()..add(CheckConnectivity()),
        ),
        BlocProvider(
          create: (context) => getIt<ImageProcessingBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Picsart AI tools',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ConenctivityHandler(),
      ),
    );
  }
}
