// lib/presentation/state/bg_settings_model.dart



class BgSettingsModel {
  final String outputType;
  final String? bgColor;
  final int bgBlur;
  final int? bgWidth;
  final int? bgHeight;
  final String scale;
  final bool autoCenter;
  final int strokeSize;
  final String strokeColor;
  final int strokeOpacity;
  final String shadow;
  final int shadowOpacity;
  final int shadowBlur;
  final int? shadowOffsetX;
  final int? shadowOffsetY;
  final String format;

  const BgSettingsModel({
    this.outputType = 'cutout',
    this.bgColor = 'FFFFFF',
    this.bgBlur = 0,
    this.bgWidth,
    this.bgHeight,
    this.scale = 'fit',
    this.autoCenter = false,
    this.strokeSize = 0,
    this.strokeColor = 'FFFFFF',
    this.strokeOpacity = 100,
    this.shadow = 'disabled',
    this.shadowOpacity = 20,
    this.shadowBlur = 50,
    this.shadowOffsetX = 0,
    this.shadowOffsetY = 0,
    this.format = 'PNG',
  });

  BgSettingsModel copyWith({
    String? outputType,
    String? bgColor,
    int? bgBlur,
    int? bgWidth,
    int? bgHeight,
    String? scale,
    bool? autoCenter,
    int? strokeSize,
    String? strokeColor,
    int? strokeOpacity,
    String? shadow,
    int? shadowOpacity,
    int? shadowBlur,
    int? shadowOffsetX,
    int? shadowOffsetY,
    String? format,
  }) {
    return BgSettingsModel(
      outputType: outputType ?? this.outputType,
      bgColor: bgColor ?? this.bgColor,
      bgBlur: bgBlur ?? this.bgBlur,
      bgWidth: bgWidth ?? this.bgWidth,
      bgHeight: bgHeight ?? this.bgHeight,
      scale: scale ?? this.scale,
      autoCenter: autoCenter ?? this.autoCenter,
      strokeSize: strokeSize ?? this.strokeSize,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeOpacity: strokeOpacity ?? this.strokeOpacity,
      shadow: shadow ?? this.shadow,
      shadowOpacity: shadowOpacity ?? this.shadowOpacity,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      shadowOffsetX: shadowOffsetX ?? this.shadowOffsetX,
      shadowOffsetY: shadowOffsetY ?? this.shadowOffsetY,
      format: format ?? this.format,
    ); 
  }
}
