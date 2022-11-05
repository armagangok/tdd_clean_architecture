import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'feature/number_trivia/data/repository/number_trivia_repository_imp.dart';
import 'feature/number_trivia/data/source/local.dart';
import 'feature/number_trivia/data/source/remote.dart';
import 'feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'feature/number_trivia/domain/usecase/get_random_number_triva.dart';
import 'feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: getIt(),
      getRandomNumberTrivia: getIt(),
      inputConverter: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetConcreteNumberTrivia(getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTrivia(repository: getIt()));
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImp(
      localDataSource: getIt(),
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSoureImp(client: getIt()));
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(sharedPreferences: getIt()));
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp());

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  // getIt.registerLazySingleton(() => DataConnectionChecker());
}
