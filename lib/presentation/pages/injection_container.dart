import 'package:get_it/get_it.dart';
import 'package:weather/data/data_sources/remote_data_source.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/repository/weather_repository.dart';
import 'package:weather/domain/usecase/get_current_weather.dart';
import 'package:weather/presentation/block/weather_block.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => WeatherBlock(locator()));

  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataaSource: locator()),
  );

  locator.registerLazySingleton<WeatherRemoteDataaSource>(
    () => WeatherRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton(() => http.Client());
}
