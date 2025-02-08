import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCUrrentWeather(String cityName);
}
