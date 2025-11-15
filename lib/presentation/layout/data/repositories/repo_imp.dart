import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:news/presentation/layout/data/repositories/repo.dart';

import '../../../../core/services/error_handler.dart';
import '../data_sources/data_source.dart';
import '../models/source_model/Source_Response.dart';
import '../models/source_model/sources.dart';

@Injectable(as: MainRepo)
class MainRepoImp implements MainRepo {
  final MainDataSource mainDataSource;
  MainRepoImp({required this.mainDataSource});

  @override
  Future<Either<ErrorHandler, List<Source>>> getSources({
    required String category,
  }) async {
    try {
      final response = await mainDataSource.getSources(category: category);

      if (response.statusCode == 200) {
        SourceResponse data = SourceResponse.fromJson(response.data);

        return Right(data.sources ?? []);
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
