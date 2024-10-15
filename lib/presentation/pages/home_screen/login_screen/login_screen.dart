import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/core/utils/app_color.dart';
import 'package:image_processing_ai_tool/core/utils/constants.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/home_screen.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/auth_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/login_page_events.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/login_page_state.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _apiController = TextEditingController(
      // text:
      //     "eyJraWQiOiI5NzIxYmUzNi1iMjcwLTQ5ZDUtOTc1Ni05ZDU5N2M4NmIwNTEiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhdXRoLXNlcnZpY2UtMWE2YWJjN2YtZjcyMS00NGRmLThmYWMtYjZkOGRhMDM5YTQzIiwiYXVkIjoiMjI3ODc3ODkwMDI4MTAyIiwibmJmIjoxNzI0MjMzNjY0LCJzY29wZSI6WyJiMmItYXBpLmdlbl9haSIsImIyYi1hcGkuaW1hZ2VfYXBpIl0sImlzcyI6Imh0dHBzOi8vYXBpLnBpY3NhcnQuY29tL3Rva2VuLXNlcnZpY2UiLCJvd25lcklkIjoiMjI3ODc3ODkwMDI4MTAyIiwiaWF0IjoxNzI0MjMzNjY0LCJqdGkiOiJkNzRjM2FhMS00ZTk3LTQ4MmEtYmIyOS1iMzcxY2Y1ZTFjYTUifQ.IlRiqhz6SEl2wF1pp0JDo7pkpGyht4k-9IV3GwY7B3YRjpfl-PCVwL-uHFGCtaEOJ33YEUGfsYZSIfZpPU01IrW-WQcosPtTSbnEEG_HYXOZZnk6T_o9YlUTOq-y2Y2Ca5o7w64fwMbdfPlZud0YGaxcxwrCI7G0nRlMrUhDDU56T1LA7g4yytFZNhbjT26P2Oe3gp7_ScNaMi0aegP-RUqmLZNPD6IRSmDS_6Xntw2n4riM-fDiJlT-krUdOqI8liUh-cWQvgmxeJz2ZYZfj_zEWKUdR4_yUqiOwGy3ospa27_1bh7MItBUoJ2argm0c1D0acRFbVxzRfQSzOFP6Q"
      );

  void _redirectForKey() async {
    final Uri uri = Uri.parse(Constants.redirectUri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Couldnt launch Page";
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is NotValidApiState) { 
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 250, 161, 219),
                    title: const Center(
                      child: Text(
                        "Invalid API key",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Color(0xFFFF35B8),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else if (state is IsValidApiStateChecking) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: CircularProgressIndicator()),
                    );
                  });
            } else if (state is IsValidApiState || state is LogedState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: appBgColor,
            )),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Welcome to our app where you can remove background of image and upscale images using PicsArt tools",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          _redirectForKey();
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xFFFF35B8))),
                        child: const Text(
                          "Log in with Picsart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "After you Log in with picsart, you need copy and past KEY provided by Picsart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        obscureText: true,
                        controller: _apiController,
                        decoration: InputDecoration(
                          hintText: "Enter KEY from PicsArt",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xFFFF35B8),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xFFFF35B8),
                            ),
                          ),
                          enabled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xFFFF35B8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextButton(
                        onPressed: () {
                          final String termKey = _apiController.text;
                          final String key = termKey.replaceAll(' ', '');
                          BlocProvider.of<AuthBloc>(context)
                              .add(IsValidAPI(key: key));
                        },
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xFFFF35B8),
                            ),
                            iconSize: WidgetStatePropertyAll(50),
                            iconColor: WidgetStatePropertyAll(Colors.white),
                            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                                vertical: 0, horizontal: 30))),
                        child: const Text(
                          "Let's start",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
