import 'package:http/http.dart' as http;
import 'package:image_processing_ai_tool/presentation/state/bg_settings_model.dart';
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BgRemoveService {
  final String BASE_URL = 'https://api.picsart.io/tools/1.0/removebg';
  Future<http.Response> removeBg(
      ImageViewModel imageViewModel, BgSettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();

    final request = http.MultipartRequest('POST', Uri.parse(BASE_URL))
      ..headers['X-Picsart-API-Key'] = prefs.getString('apiKey')!
      // "eyJraWQiOiI5NzIxYmUzNi1iMjcwLTQ5ZDUtOTc1Ni05ZDU5N2M4NmIwNTEiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhdXRoLXNlcnZpY2UtMWE2YWJjN2YtZjcyMS00NGRmLThmYWMtYjZkOGRhMDM5YTQzIiwiYXVkIjoiMjI3ODc3ODkwMDI4MTAyIiwibmJmIjoxNzI0MjMzNjY0LCJzY29wZSI6WyJiMmItYXBpLmdlbl9haSIsImIyYi1hcGkuaW1hZ2VfYXBpIl0sImlzcyI6Imh0dHBzOi8vYXBpLnBpY3NhcnQuY29tL3Rva2VuLXNlcnZpY2UiLCJvd25lcklkIjoiMjI3ODc3ODkwMDI4MTAyIiwiaWF0IjoxNzI0MjMzNjY0LCJqdGkiOiJkNzRjM2FhMS00ZTk3LTQ4MmEtYmIyOS1iMzcxY2Y1ZTFjYTUifQ.IlRiqhz6SEl2wF1pp0JDo7pkpGyht4k-9IV3GwY7B3YRjpfl-PCVwL-uHFGCtaEOJ33YEUGfsYZSIfZpPU01IrW-WQcosPtTSbnEEG_HYXOZZnk6T_o9YlUTOq-y2Y2Ca5o7w64fwMbdfPlZud0YGaxcxwrCI7G0nRlMrUhDDU56T1LA7g4yytFZNhbjT26P2Oe3gp7_ScNaMi0aegP-RUqmLZNPD6IRSmDS_6Xntw2n4riM-fDiJlT-krUdOqI8liUh-cWQvgmxeJz2ZYZfj_zEWKUdR4_yUqiOwGy3ospa27_1bh7MItBUoJ2argm0c1D0acRFbVxzRfQSzOFP6Q"
      ..headers['accept'] = 'application/json'
      ..fields['output_type'] = settings.outputType // +
      ..fields['bg_color'] = settings.bgColor.toString() //
      ..fields['bg_blur'] = settings.bgBlur.toString() //
      ..fields['scale'] = settings.scale // +
      ..fields['auto_center'] = (settings.autoCenter) ? "true" : "false"
      ..fields['stroke_size'] = settings.strokeSize.toString()
      ..fields['stroke_color'] = settings.strokeColor
      ..fields['stroke_opacity'] = settings.strokeOpacity.toString()
      ..fields['shadow'] = settings.shadow
      ..fields['shadow_offset_x'] = settings.shadowOffsetX.toString()
      ..fields['shadow_offset_y'] = settings.shadowOffsetY.toString()
      ..fields['shadow_opacity'] = settings.shadowOpacity.toString()
      ..fields['shadow_blur'] = settings.shadowBlur.toString()
      ..fields['format'] = settings.format;

    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageViewModel.imageBytes!,
      filename: 'image_${DateTime.now().millisecondsSinceEpoch}.${settings.format}',
    ));
    final streamedResponse = await request.send();

    return await http.Response.fromStream(streamedResponse);
  }
}
