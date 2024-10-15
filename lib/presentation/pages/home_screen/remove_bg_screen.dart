import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_event.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_state.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';
import 'package:image_processing_ai_tool/presentation/widgets/image_showing_canvas.dart';
import 'package:image_processing_ai_tool/presentation/widgets/processing_buttons.dart';
import 'package:image_processing_ai_tool/presentation/widgets/remove_bg_screen_widgets/remove_bg_guide.dart';
import 'package:image_processing_ai_tool/presentation/widgets/remove_bg_screen_widgets/remove_bg_header.dart';
import 'package:image_processing_ai_tool/presentation/widgets/remove_bg_screen_widgets/remove_bg_settings.dart';

class RemoveBgScreen extends StatelessWidget {
  const RemoveBgScreen({super.key});

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFF09FACA),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const RemoveBgHeader(),
              const RemoveBgGuide(),
              const SizedBox(
                height: 25,
              ),
              OutlinedButton(
                onPressed: () {
                  BlocProvider.of<ImageProcessingBloc>(context)
                      .add(PickRemoveBgImage());
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFFF35B8))),
                child: const Text(
                  "Upload Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocConsumer<ImageProcessingBloc, ImageProcessingState>(
                listener: (context, state) {
                  if (state is BgRemovedSaving) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Row(
                              children: [
                                CircularProgressIndicator(),
                                Text("Saving the image"),
                              ],
                            )),
                      );
                    });
                  } else if (state is UpscaledSaved) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Row(
                          children: [
                            CircularProgressIndicator(),
                            Text("Image saved!"),
                          ],
                        )),
                      );
                    });
                  } else if (state is UpscaledSavingFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    });
                  } else if (state is RemoveBgLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You can process ${(state.limit??"null")} images')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is BgRemoveImagePicking) {
                    return Center(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: const CircularProgressIndicator()),
                    );
                  } else if (state is BgRemoveImagePickFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    });
                  } else if (state is BgRemoveImagePicked) {
                    return Column(
                      children: [
                        ImageShowingCanvas(
                          image: Image.memory(
                            state.imageBytes!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        //settings
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: RemoveBgSettings(),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.settings)),
                        ProcessingButtons(
                          firstText: 'Remove BG',
                          secondText: 'Save',
                          processImage: (state.imageBytes != null)
                              ? () {
                                  final currentSettings = context
                                      .read<ImageProcessingBloc>()
                                      .currentSettings;
                                  print("Esia $currentSettings");
                                  BlocProvider.of<ImageProcessingBloc>(context)
                                      .add(
                                    RemoveBgEvent(
                                      viewModel: ImageViewModel(
                                        imageBytes: state.imageBytes,
                                      ),
                                      bgSettingsModel: currentSettings,
                                    ),
                                  );
                                }
                              : null,
                          saveImage: null,
                        ),
                      ],
                    );
                  } else if (state is RemoveBgLoading) {
                    return Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width / 2,
                            width: MediaQuery.of(context).size.width / 2,
                            child: const CircularProgressIndicator()),
                      ),
                    );
                  } else if (state is RemoveBgLoaded) {
                    return Column(
                      children: [
                        ImageShowingCanvas(
                          image: Image.memory(
                            state.imageBytes!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ProcessingButtons(
                          firstText: 'Remove BG',
                          secondText: 'Save',
                          processImage: null,
                          saveImage: () {
                            BlocProvider.of<ImageProcessingBloc>(context).add(
                                SaveBgRemovedImage(
                                    imageBytes: state.imageBytes));
                          },
                        ),
                      ],
                    );
                  } else if (state is RemoveBgLFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    });
                  }
                  return ImageShowingCanvas(
                    image: Image.asset(
                      "assets/default_placeholder.png",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
