import 'package:either_dart/either.dart';
import 'package:news/core/services/error_handler.dart';
import 'package:news/presentation/news/data/models/articles.dart';
import '../../../layout/data/models/source_model/sources.dart';

abstract class NewsRepo {
  Future<Either<ErrorHandler, List<Article>>> getNews(Source source);
}
