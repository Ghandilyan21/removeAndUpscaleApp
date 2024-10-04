import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BgRemoveService {
  final String BASE_URL = 'https://api.picsart.io/tools/1.0/removebg';
  Future<http.Response> removeBg(Uint8List image) async {
    final prefs = await SharedPreferences.getInstance();

    final request = http.MultipartRequest('POST', Uri.parse(BASE_URL))
      ..headers['X-Picsart-API-Key'] =
          prefs.getString('apiKey')!
      ..headers['accept'] = 'application/json'
      ..fields['output_type'] = 'cutout'
      ..fields['bg_blur'] = '0'
      ..fields['scale'] = 'fit'
      ..fields['auto_center'] = 'false'
      ..fields['stroke_size'] = '0'
      ..fields['stroke_color'] = 'FFFFFF'
      ..fields['stroke_opacity'] = '100'
      ..fields['shadow'] = 'disabled'
      ..fields['shadow_opacity'] = '20'
      ..fields['shadow_blur'] = '50'
      ..fields['format'] = 'PNG';
    request.files.add(http.MultipartFile.fromBytes(
      'image', image, filename: 'image.png', 
    ));
    final streamedResponse = await request.send();

    return await http.Response.fromStream(streamedResponse);
  }
}
