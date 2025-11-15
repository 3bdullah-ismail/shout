import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network_services.dart';
import 'data_source.dart';

@Injectable(as: MainDataSource)
class MainDataSourceImp implements MainDataSource {
  final NetworkService networkService;
  MainDataSourceImp({required this.networkService});

  @override
  Future<Response> getSources({required String category}) {
    return networkService.dio.get(
      "/v2/top-headlines/sources",
      queryParameters: {"category": category},
    );
  }
}
