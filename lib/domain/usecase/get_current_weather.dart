import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repository/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUseCase(this.weatherRepository);
  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCUrrentWeather(cityName);
  }
}
