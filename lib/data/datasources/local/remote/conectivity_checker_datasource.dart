import 'package:image_processing_ai_tool/data/datasource_services/check_connectivity_service.dart';

class ConectivityCheckerDatasource {
  final CheckConnectivityService conectivityService;

  ConectivityCheckerDatasource({required this.conectivityService});
  Future<bool> get isConnected async {
    return await conectivityService.isConected;
  }
}