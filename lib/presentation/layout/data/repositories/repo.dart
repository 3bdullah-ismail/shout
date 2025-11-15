import 'package:either_dart/either.dart';

import '../../../../core/services/error_handler.dart';
import '../models/source_model/sources.dart';

abstract class MainRepo {
  Future<Either<ErrorHandler, List<Source>>> getSources({
    required String category,
  });
}
