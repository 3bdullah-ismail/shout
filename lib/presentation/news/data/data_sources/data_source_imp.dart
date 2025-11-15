import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news/core/services/network_services.dart';
import 'package:news/presentation/layout/data/models/source_model/sources.dart';

import 'data_source.dart';

@Injectable(as: NewsDataSource)
class NewsDataSourceImp implements NewsDataSource {
  NetworkService networkService;
  NewsDataSourceImp(this.networkService);
  @override
  Future<Response> getNews(Source source) {
    return networkService.dio.get(
      "/v2/everything",
      queryParameters: {"sources": source.id},
    );
  }
}
