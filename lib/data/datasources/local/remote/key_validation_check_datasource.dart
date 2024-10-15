
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class KeyValidationCheckDatasource {
  final String BASE_URL = 'https://api.picsart.io/tools/1.0/removebg';
  
  Future<bool> isValidKey(String key) async {
    // final hardKey = 'eyJraWQiOiI5NzIxYmUzNi1iMjcwLTQ5ZDUtOTc1Ni05ZDU5N2M4NmIwNTEiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhdXRoLXNlcnZpY2UtMWE2YWJjN2YtZjcyMS00NGRmLThmYWMtYjZkOGRhMDM5YTQzIiwiYXVkIjoiMjI3ODc3ODkwMDI4MTAyIiwibmJmIjoxNzI0MjMzNjY0LCJzY29wZSI6WyJiMmItYXBpLmdlbl9haSIsImIyYi1hcGkuaW1hZ2VfYXBpIl0sImlzcyI6Imh0dHBzOi8vYXBpLnBpY3NhcnQuY29tL3Rva2VuLXNlcnZpY2UiLCJvd25lcklkIjoiMjI3ODc3ODkwMDI4MTAyIiwiaWF0IjoxNzI0MjMzNjY0LCJqdGkiOiJkNzRjM2FhMS00ZTk3LTQ4MmEtYmIyOS1iMzcxY2Y1ZTFjYTUifQ.IlRiqhz6SEl2wF1pp0JDo7pkpGyht4k-9IV3GwY7B3YRjpfl-PCVwL-uHFGCtaEOJ33YEUGfsYZSIfZpPU01IrW-WQcosPtTSbnEEG_HYXOZZnk6T_o9YlUTOq-y2Y2Ca5o7w64fwMbdfPlZud0YGaxcxwrCI7G0nRlMrUhDDU56T1LA7g4yytFZNhbjT26P2Oe3gp7_ScNaMi0aegP-RUqmLZNPD6IRSmDS_6Xntw2n4riM-fDiJlT-krUdOqI8liUh-cWQvgmxeJz2ZYZfj_zEWKUdR4_yUqiOwGy3ospa27_1bh7MItBUoJ2argm0c1D0acRFbVxzRfQSzOFP6Q';

    // print(hardKey.length);
    // print(key.length);
    final imageData = await rootBundle.load('assets/default_placeholder.png');
    Uint8List imageBytes = imageData.buffer.asUint8List();
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
      ..fields['format'] = 'PNG';
      // ..fields['image'] = imageBytes;
      request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image_${DateTime.now().millisecondsSinceEpoch}',
    ));

      final response = await request.send();
      print(response.statusCode);
      final res = await http.Response.fromStream(response);
        print(res.body);
      if (response.statusCode == 200) {
        // final res = await http.Response.fromStream(response);
        // print(res.body);
        return true;
      }
      else {
        return false;
      }
  }
}

