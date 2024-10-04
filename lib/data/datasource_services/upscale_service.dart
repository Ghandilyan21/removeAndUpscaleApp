import 'package:http/http.dart' as http;
import 'package:image_processing_ai_tool/presentation/state/image_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpscaleService {
  final String BASE_URL = 'https://api.picsart.io/tools/1.0/upscale';
  Future<http.Response> upscaleImage(ImageViewModel image, String size) async {
    final prefs = await SharedPreferences.getInstance();

    final request = http.MultipartRequest('POST', Uri.parse(BASE_URL))
      ..headers['X-Picsart-API-Key'] = prefs.getString('apiKey')!
      ..headers['accept'] = 'application/json'
      ..fields['upscale_factor'] = size
      ..fields['format'] = 'PNG';
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      image.imageBytes!,
      filename: 'image.png',
    ));
    final streamedResponse = await request.send();

    return await http.Response.fromStream(streamedResponse);
  }
}
