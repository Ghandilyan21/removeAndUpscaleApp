import 'package:http/http.dart' as http;

class KeyValidationCheckDatasource {
  final String BASE_URL = 'https://api.picsart.io/tools/1.0/removebg';
  
  Future<bool> isValidKey(String key) async {
    final request = http.MultipartRequest('POST', Uri.parse(BASE_URL))
      ..headers['X-Picsart-API-Key'] = key
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
      ..fields['format'] = 'PNG'
      ..fields['image_url'] = 'https://via.placeholder.com/150';

      final response = await request.send();
      if (response.statusCode == 200) {
        return true;
      }
      else {
        return false;
      }
  }
}

