import 'package:dio/dio.dart';

abstract class MainDataSource {
  Future<Response> getSources({required String category});
}
