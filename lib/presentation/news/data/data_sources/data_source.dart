import 'package:dio/dio.dart';

import '../../../layout/data/models/source_model/sources.dart';

abstract class NewsDataSource {
  Future<Response> getNews(Source source);
}
