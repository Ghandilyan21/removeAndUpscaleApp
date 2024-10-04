import 'package:flutter/material.dart';
import 'package:image_processing_ai_tool/core/utils/app_color.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/remove_bg_screen.dart';
import 'package:image_processing_ai_tool/presentation/pages/home_screen/upscale_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [const RemoveBgScreen(), UpscaleScreen()];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Picsart AI tools",
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    text: "Remove BG",
                  ),
                  Tab(
                    text: "Upscale",
                  ),
                ],
              ),
              Expanded(child: TabBarView(children: pages)),
            ],
          ),
        ),
      ),
    );
  }
}
