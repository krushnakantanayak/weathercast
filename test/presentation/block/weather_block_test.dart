import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/presentation/block/weather_block.dart';
import 'package:weather/presentation/block/weather_event.dart';
import 'package:weather/presentation/block/weather_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBlock weatherBlock;
  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBlock = WeatherBlock(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('intial state should be empty', () {
    expect(weatherBlock.state, WeatherEmpty());
  });

  blocTest<WeatherBlock, WeatherState>('WeatherLoading and WeatherLoaded  data is gotten sucess',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer((_) async => const Right(testWeather));
        return weatherBlock;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(testWeather)]);

  blocTest<WeatherBlock, WeatherState>('WeatherLoading and WeatherLoaded  data is gotten unsucess ',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer((_) async => const Left(ServerFailure('Server failure')));
        return weatherBlock;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoadFailue('Server failure'),
          ]);
}
