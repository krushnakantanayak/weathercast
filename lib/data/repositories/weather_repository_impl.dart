import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/data/data_sources/remote_data_source.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  late WeatherRemoteDataaSource weatherRemoteDataaSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataaSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCUrrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataaSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
