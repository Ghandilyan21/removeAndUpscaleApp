import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivityService {
  Connectivity connectivity = Connectivity();
  Future<bool> get isConected async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    return result[0] != ConnectivityResult.none;
  }
}