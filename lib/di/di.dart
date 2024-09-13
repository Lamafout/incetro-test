import 'package:get_it/get_it.dart';
import 'package:incetro_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:incetro_test/features/auth/data/sources/local_source.dart';
import 'package:incetro_test/features/auth/data/sources/remote_source.dart';
import 'package:incetro_test/features/auth/domain/usecases/auth_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt di = GetIt.instance;

void setupDi() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(sharedPreferences);
  di.registerLazySingleton<LocalSource>(() => LocalSource(sharedPreferences));
  di.registerLazySingleton<RemoteSource>(() => RemoteSource());
  di.registerLazySingleton<AuthRepositoryImpl>(()=>AuthRepositoryImpl(localSource: di<LocalSource>(), remoteSource: di<RemoteSource>()));
  di.registerLazySingleton<AuthUsecases>(() => AuthUsecases(di<AuthRepositoryImpl>()));
}