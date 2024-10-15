import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_event.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_state.dart';
import 'package:image_processing_ai_tool/presentation/widgets/image_showing_canvas.dart';
import 'package:image_processing_ai_tool/presentation/widgets/processing_buttons.dart';
import 'package:image_processing_ai_tool/presentation/widgets/upscale_screen_widgets/upscale_guide.dart';
import 'package:image_processing_ai_tool/presentation/widgets/upscale_screen_widgets/upscale_header.dart';
import 'package:image_processing_ai_tool/presentation/widgets/upscale_screen_widgets/upscale_size_choose.dart';

class UpscaleScreen extends StatelessWidget {
  UpscaleScreen({super.key});
  final GlobalKey<FormFieldState<String>> _dropdownKey =
      GlobalKey<FormFieldState<String>>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFF09FACA),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const UpscaleHeader(),
              const UpscaleGuide(),
              const SizedBox(
                height: 25,
              ),
              OutlinedButton(
                onPressed: () {
                  BlocProvider.of<ImageProcessingBloc>(context)
                      .add(PickUpsclaeImage());
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
                  if (state is UpscaledSaving) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Row(
                          children: [
                            CircularProgressIndicator(),
                            Text("Saving the image"),
                          ],
                        )),
                      );
                    });
                  }
                  if (state is BgRemovedSaved) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Image saved!"),
                        ),
                      );
                    });
                  } else if (state is BgRemovedSavingFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    });
                  }
                  else if (state is UpscaleLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You can process ${(state.limit??"null")} images')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpscaleImagePicking) {
                    return Center(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: const CircularProgressIndicator()),
                    );
                  } else if (state is UpscaleImagePicked) {
                    return Column(
                      children: [
                        ImageShowingCanvas(
                          image: Image.memory(
                            (state.imageBytes!.imageBytes)!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        UpscaleSizeChoose(_dropdownKey),
                        const SizedBox(
                          height: 25,
                        ),
                        ProcessingButtons(
                          firstText: 'Upscale',
                          secondText: 'Save',
                          processImage: () {
                            BlocProvider.of<ImageProcessingBloc>(context).add(
                                UpscaleImageEvent(
                                    imageBytes: state.imageBytes!,
                                    size: _dropdownKey.currentState?.value ??
                                        '2'));
                          },
                          saveImage: null,
                        ),
                      ],
                    );
                  } else if (state is UpscaleLoading) {
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
                  } else if (state is UpscaleLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Image upscaled ${state.upscaledSize} times')),
                      );
                    });
                    return Column(
                      children: [
                        ImageShowingCanvas(
                          image: Image.memory(
                            (state.imageBytes!.imageBytes)!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ProcessingButtons(
                          firstText: 'Upscale',
                          secondText: 'Save',
                          processImage: null,
                          saveImage: () {
                            BlocProvider.of<ImageProcessingBloc>(context).add(
                                SaveUpscaledImage(
                                    imageBytes: state.imageBytes!.imageBytes,
                                    size: state.upscaledSize));
                          },
                        ),
                      ],
                    );
                  } else if (state is UpscaleFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    });
                  }
                  return Column(
                    children: [
                      ImageShowingCanvas(
                        image: Image.asset(
                          'assets/default_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
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
