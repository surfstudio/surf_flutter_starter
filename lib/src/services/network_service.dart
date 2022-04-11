import 'package:dio/dio.dart';
import 'package:surf_flutter_starter/src/exceptions.dart';
import 'package:surf_flutter_starter/src/utils/logger.dart';

/// Implements network-based calls & requests.
// ignore: one_member_abstracts
abstract class NetworkService {
  /// Downloads file from [url] & stores it to [path].
  ///
  /// Returns 'void'
  ///
  /// May throw [NetworkException] on error.
  Future<void> download({required String url, required String path});
}

/// Implements [NetworkService] interface, uses [Dio] as network client.
class DioService implements NetworkService {
  /// Network client instance.
  final Dio dio;

  /// Constructor for [DioService], in which network client is passed.
  DioService(this.dio);

  @override
  Future<void> download({required String url, required String path}) async {
    try {
      Logger.fine(path);
      final result = await dio.download(url, path);
      if (result.statusCode == null || result.statusCode! >= 300) {
        Logger.error(result.data.toString());
        throw NetworkException(result.data.toString(), result.statusCode);
      }
      return;
    } on DioError catch (e) {
      Logger.error(e.message);
      throw NetworkException(e.message, e.response?.statusCode);
    }
  }
}
