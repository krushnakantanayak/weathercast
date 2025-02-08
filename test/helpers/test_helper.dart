import 'package:mockito/annotations.dart';
import 'package:weather/data/data_sources/remote_data_source.dart';
import 'package:weather/domain/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather/domain/usecase/get_current_weather.dart';

// generate mock file to crate stubing
@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataaSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
