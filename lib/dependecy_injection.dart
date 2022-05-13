import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:stonks/core/exception_convector.dart';
import 'package:stonks/data/datasources/follow_stock_datasource.dart';
import 'package:stonks/data/datasources/follow_stock_local_datasource.dart';
import 'package:stonks/data/repositories/follow_stock_repository_impl.dart';
import 'package:stonks/domain/repositories/follow_stock_repository.dart';
import 'package:stonks/domain/usecases/follow_stock_usecases.dart';
import 'package:stonks/domain/usecases/search_stock_usecases.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/search_stock_cubit.dart';

import 'data/datasources/search_stock_datasource.dart';
import 'data/datasources/search_stock_remote_datasource.dart';
import 'data/repositories/search_stock_repository_impl.dart';
import 'domain/repositories/search_stock_repository.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void setupDependency() {
  getIt.registerLazySingleton<ExceptionConvector>(() => ExceptionConvector());

  // Follow stock
  getIt.registerFactory<FollowStockCubit>(
    () => FollowStockCubit(useCases: getIt()),
  );
  getIt.registerLazySingleton<FollowStockUseCases>(
    () => FollowStockUseCases(
      repository: getIt(),
      exceptionConvector: getIt(),
    ),
  );
  getIt.registerLazySingleton<FollowStockRepository>(
    () => FollowStockRepositoryImpl(datasource: getIt()),
  );
  getIt.registerLazySingleton<FollowStockDatasource>(
    () => FollowStockLocalDatasource(),
  );

  // Search stock
  getIt.registerFactory<SearchStockCubit>(
      () => SearchStockCubit(useCases: getIt()));
  getIt.registerLazySingleton<SearchStockUseCases>(
    () => SearchStockUseCases(
      repository: getIt(),
      exceptionConvector: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchStockRepository>(
    () => SearchStockRepositoryImpl(datasource: getIt()),
  );

  getIt.registerLazySingleton<SearchStockDatasource>(
    () => SearchStockRemoteDatasource(
      client: http.Client(),
      connectivity: Connectivity(),
    ),
  );
}
