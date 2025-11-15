import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class NetworkService {
  static const String apiKey = "9cd6d0587c78416ca1e2a245298c3dba";

  late Dio dio;

  NetworkService() {
    intl();
  }

  void intl() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://newsapi.org",
        queryParameters: {"apikey": apiKey},
        followRedirects: false,
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(requestBody: true, request: true, requestHeader: true),
    );
  }
}
