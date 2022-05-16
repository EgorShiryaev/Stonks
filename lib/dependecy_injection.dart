import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/datasources.dart';
import 'domain/repositories/repositories.dart';
import 'domain/usecases/usecases.dart';
import 'exceptions/exceptions.dart';
import 'presentation/BLoCs/blocs.dart';
import 'services/services.dart';

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
    () => SearchStockCubit(useCases: getIt()),
  );

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

  // Listen last price
  getIt.registerFactory<ListenLastPriceCubit>(
    () => ListenLastPriceCubit(
      service: getIt(),
      connectivity: Connectivity(),
    ),
  );

  getIt.registerLazySingleton<ListenLastPriceService>(
    () => ListenLastPriceService(),
  );
}
