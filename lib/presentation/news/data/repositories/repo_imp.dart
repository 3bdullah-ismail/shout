import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:news/core/services/error_handler.dart';
import 'package:news/presentation/layout/data/models/source_model/sources.dart';
import 'package:news/presentation/news/data/models/articles.dart';
import 'package:news/presentation/news/data/models/news_response.dart';
import 'package:news/presentation/news/data/repositories/repo.dart';
import '../data_sources/data_source.dart';

@Injectable(as: NewsRepo)
class NewsRepoImp implements NewsRepo {
  NewsDataSource newsDataSource;
  NewsRepoImp(this.newsDataSource);

  @override
  Future<Either<ErrorHandler, List<Article>>> getNews(Source source) async {
    try {
      final response = await newsDataSource.getNews(source);
      if (response.statusCode == 200) {
        NewsResponse data = NewsResponse.fromJson(response.data);
        return Right(data.articles ?? []);
      } else {
        return Left(ErrorHandler.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(
        ErrorHandler.fromJson(e.response?.data ?? {"message": e.message}),
      );
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }
}
