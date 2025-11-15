// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/layout/data/data_sources/data_source.dart' as _i521;
import '../../presentation/layout/data/data_sources/data_source_imp.dart'
    as _i1008;
import '../../presentation/layout/data/repositories/repo.dart' as _i940;
import '../../presentation/layout/data/repositories/repo_imp.dart' as _i406;
import '../../presentation/layout/presentation/manager/main_cubit.dart'
    as _i344;
import '../../presentation/news/data/data_sources/data_source.dart' as _i340;
import '../../presentation/news/data/data_sources/data_source_imp.dart'
    as _i897;
import '../../presentation/news/data/repositories/repo.dart' as _i12;
import '../../presentation/news/data/repositories/repo_imp.dart' as _i651;
import '../../presentation/news/presentation/manager/news_cubit.dart' as _i6;
import '../services/network_services.dart' as _i642;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i642.NetworkService>(() => _i642.NetworkService());
    gh.factory<_i340.NewsDataSource>(
      () => _i897.NewsDataSourceImp(gh<_i642.NetworkService>()),
    );
    gh.factory<_i12.NewsRepo>(
      () => _i651.NewsRepoImp(gh<_i340.NewsDataSource>()),
    );
    gh.factory<_i521.MainDataSource>(
      () =>
          _i1008.MainDataSourceImp(networkService: gh<_i642.NetworkService>()),
    );
    gh.factory<_i6.NewsCubit>(
      () => _i6.NewsCubit(newsRepo: gh<_i12.NewsRepo>()),
    );
    gh.factory<_i940.MainRepo>(
      () => _i406.MainRepoImp(mainDataSource: gh<_i521.MainDataSource>()),
    );
    gh.factory<_i344.MainCubit>(
      () => _i344.MainCubit(mainRepo: gh<_i940.MainRepo>()),
    );
    return this;
  }
}
