import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/image_processing_bloc.dart';
import '../../state/image_processing_event.dart';
import '../../state/bg_settings_model.dart';

class RemoveBgSettings extends StatefulWidget {
  const RemoveBgSettings({super.key});

  @override
  _RemoveBgSettingsState createState() => _RemoveBgSettingsState();
}

class _RemoveBgSettingsState extends State<RemoveBgSettings> {
  final _formKey = GlobalKey<FormState>();
  late BgSettingsModel _settings;

  @override
  void initState() {
    super.initState();
    // Get current settings from BLoC
    final currentSettings = context.read<ImageProcessingBloc>().currentSettings;
    _settings = currentSettings.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Output Type
            DropdownButtonFormField<String>(
              value: _settings.outputType,
              decoration: const InputDecoration(labelText: 'Output Type'),
              items: const [
                DropdownMenuItem(value: 'cutout', child: Text('Cutout')),
                DropdownMenuItem(value: 'mask', child: Text('Mask')),
              ],
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(outputType: value);
                });
              },
            ),
            // Background Color
            TextFormField(
              initialValue: _settings.bgColor,
              decoration: const InputDecoration(labelText: 'Background Color'),
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(bgColor: value);
                });
              },
            ),
            // Background Blur
            if(_settings.outputType != 'mask')
              SliderFormField(
                label: 'Background Blur',
                initialValue: _settings.bgBlur.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(bgBlur: value.toInt());
                  });
                },
              ),
            // Scale
            DropdownButtonFormField<String>(
              value: _settings.scale,
              decoration: const InputDecoration(labelText: 'Scale'),
              items: const [
                DropdownMenuItem(value: 'fit', child: Text('Fit')),
                DropdownMenuItem(value: 'fill', child: Text('Fill')),
              ],
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(scale: value);
                });
              },
            ),
            // Auto Center
            if (_settings.outputType != 'mask')
              SwitchListTile(
                title: const Text('Auto Center'),
                value: _settings.autoCenter,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(autoCenter: value);
                  });
                },
              ),
            // Stroke Size
            if (_settings.outputType != 'mask')
              SliderFormField(
                label: 'Stroke Size',
                initialValue: _settings.strokeSize.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(strokeSize: value.toInt());
                  });
                },
              ),
            // Stroke Color
            if (_settings.outputType != 'mask' && _settings.strokeSize > 0)
              TextFormField(
                initialValue: _settings.strokeColor,
                decoration: const InputDecoration(labelText: 'Stroke Color'),
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(strokeColor: value);
                  });
                },
              ),
            // Stroke Opacity
            if (_settings.outputType != 'mask' && _settings.strokeSize > 0)
              SliderFormField(
                label: 'Stroke Opacity',
                initialValue: _settings.strokeOpacity.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(strokeOpacity: value.toInt());
                  });
                },
              ),
            // Shadow
            if (_settings.outputType != 'mask' && _settings.strokeSize <= 0)
              DropdownButtonFormField<String>(
                value: _settings.shadow,
                decoration: const InputDecoration(labelText: 'Shadow'),
                items: const [
                  DropdownMenuItem(value: 'disabled', child: Text('Disabled')),
                  DropdownMenuItem(value: 'custom', child: Text('Custom')),
                  DropdownMenuItem(value: 'bottom-right', child: Text('bottom-right')),
                  DropdownMenuItem(value: 'bottom', child: Text('bottom')),
                  DropdownMenuItem(value: 'bottom-left', child: Text('bottom-left')),

                  DropdownMenuItem(value: 'left', child: Text('left')),
                  DropdownMenuItem(value: 'right', child: Text('right')),
                  DropdownMenuItem(value: 'top-left', child: Text('top-left')),
                  DropdownMenuItem(value: 'top', child: Text('top')),
                  DropdownMenuItem(value: 'top-right', child: Text('top-right')),

                ],
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(shadow: value);
                  });
                },
              ),
            // Shadow Opacity
            if (_settings.shadow != 'disabled'  && _settings.strokeSize <= 0 && _settings.outputType != 'mask')
              SliderFormField(
                label: 'Shadow Opacity',
                initialValue: _settings.shadowOpacity.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(shadowOpacity: value.toInt());
                  });
                },
              ),
            // Shadow Blur
            if (_settings.shadow != 'disabled'  && _settings.strokeSize <= 0 && _settings.outputType != 'mask')
              SliderFormField(
                label: 'Shadow Blur',
                initialValue: _settings.shadowBlur.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(shadowBlur: value.toInt());
                  });
                },
              ),
            // Shadow Offset X and Y (only if shadow is custom)
            if (_settings.shadow == 'custom' && _settings.strokeSize <= 0 && _settings.outputType != 'mask') ...[
              TextFormField(
                initialValue: _settings.shadowOffsetX?.toString(),
                decoration: const InputDecoration(labelText: 'Shadow Offset X'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(
                      shadowOffsetX: int.tryParse(value),
                    );
                  });
                },
              ),
              TextFormField(
                initialValue: _settings.shadowOffsetY?.toString(),
                decoration: const InputDecoration(labelText: 'Shadow Offset Y'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(
                      shadowOffsetY: int.tryParse(value),
                    );
                  });
                },
              ),
            ],
            // Format
            DropdownButtonFormField<String>(
              value: _settings.format,
              decoration: const InputDecoration(labelText: 'Format'),
              items: const [
                DropdownMenuItem(value: 'PNG', child: Text('PNG')),
                DropdownMenuItem(value: 'JPG', child: Text('JPG')),
                DropdownMenuItem(value: 'WEBP', child: Text('WEBP')),
              ],
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(format: value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and save settings
                if (_formKey.currentState!.validate()) {
                  context.read<ImageProcessingBloc>().add(UpdateBgSettings(_settings));
                  Navigator.of(context).pop();
                }
                else{
                  print("sxala");
                }
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for sliders with labels
class SliderFormField extends StatelessWidget {
  final String label;
  final double initialValue;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  const SliderFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$label: ${initialValue.toInt()}'),
        Slider(
          value: initialValue,
          min: min,
          max: max,
          divisions: divisions,
          label: initialValue.toInt().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
