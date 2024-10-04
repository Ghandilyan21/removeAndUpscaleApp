import 'package:http/http.dart' as http;
class ImageDownloader {
  Future<http.Response> downloadImage(String url) async {
    
      return await http.get(Uri.parse(url));
      
   
    
  }
}
