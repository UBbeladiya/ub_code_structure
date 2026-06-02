import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

/// Returns TRUE if internet is available (Wi-Fi or Mobile Data)
/// Returns FALSE if no connection OR connected but no real internet
Future<bool> isInternetAvailable() async {
  // Step 1: Check if Wi-Fi or Mobile Data is ON
  final List<ConnectivityResult> result = await Connectivity().checkConnectivity();

  final bool isConnected = result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile);

  if (!isConnected) return false; // No Wi-Fi, No Mobile Data → false

  // Step 2: Use Dio to confirm real internet access
  try {
    final Dio dio = Dio();

    dio.options = BaseOptions(connectTimeout: const Duration(seconds: 5), receiveTimeout: const Duration(seconds: 5));

    final Response response = await dio.get('https://google.com');

    // 200–299 = real internet available
    return response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300;
  } on DioException catch (e) {
    // Connected to network but no real internet
    print('Dio Error: \${e.message}');
    return false;
  } catch (_) {
    return false;
  }
}
