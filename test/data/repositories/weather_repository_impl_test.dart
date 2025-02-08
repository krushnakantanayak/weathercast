import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataaSource mockWeatherRemoteDataaSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataaSource = MockWeatherRemoteDataaSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataaSource: mockWeatherRemoteDataaSource,
    );
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group('get current weather', () {
    test('when a call to data source is sucessful', () async {
      // arrange
      when(mockWeatherRemoteDataaSource.getCurrentWeather(testCityName)).thenAnswer((_) async => testWeatherModel);

      // act
      final result = await weatherRepositoryImpl.getCUrrentWeather(testCityName);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });
  });

  test(
    'should return server failure when a call to data source is unsuccessful',
    () async {
      // arrange
      when(mockWeatherRemoteDataaSource.getCurrentWeather(testCityName)).thenThrow(ServerException());

      // act
      final result = await weatherRepositoryImpl.getCUrrentWeather(testCityName);

      // assert
      expect(result, equals(const Left(ServerFailure('An error has occurred'))));
    },
  );

  test(
    "shocket Error due to connection failure",
    () async {
      when(mockWeatherRemoteDataaSource.getCurrentWeather(testCityName)).thenThrow(const SocketException("Connection failure"));
      final result = await weatherRepositoryImpl.getCUrrentWeather(testCityName);
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    },
  );
}
