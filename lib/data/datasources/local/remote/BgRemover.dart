import 'dart:convert';
import 'dart:typed_data';
import 'package:image_processing_ai_tool/core/error/api_payment_limit_error.dart';
import 'package:image_processing_ai_tool/core/error/image_downloading_error.dart';
import 'package:image_processing_ai_tool/core/error/network_error.dart';
import 'package:image_processing_ai_tool/core/error/server_error.dart';
import 'package:image_processing_ai_tool/data/DTO/imageDTO.dart';
import 'package:image_processing_ai_tool/data/datasource_services/bg_remove_service.dart';
import 'package:image_processing_ai_tool/data/datasource_services/check_connectivity_service.dart';
import 'package:image_processing_ai_tool/data/datasource_services/image_downloader.dart';

class Bgremover {
  final BgRemoveService bgRemoveService;
  final ImageDownloader imageDownloader;
  Bgremover({required this.imageDownloader, required this.bgRemoveService});

  Future<ImageDTO> removeBg(Uint8List image) async {
    if (!(await CheckConnectivityService().isConected)) {
      throw NetworkError(
          message:
              "No internet connection. Please check your network settings.");
    }
      final response = await bgRemoveService.removeBg(image);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String url = jsonResponse['data']['url'];
          final downloadResponse = await imageDownloader.downloadImage(url);
          if (downloadResponse.statusCode == 200) {
            return ImageDTO(imageBytes: downloadResponse.bodyBytes);
          } else {
            throw ImageDownloadingError(
                message: "Failed to download image. Please try again later.");
          }
      } else if (response.statusCode == 402) {
        throw ApiPaymentLimitError(
            message: jsonDecode(response.body)['message']);
      }
      throw ServerError(message: "Server Error");
  }
}
