import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/usecase/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });
  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: "few clouds",
    iconCode: '02d',
    temperature: 302.38,
    pressure: 1009,
    humidity: 70,
  );
  const testCityName = 'New York';

  test('should get current weather detail from the repository', () async {
    when(mockWeatherRepository.getCUrrentWeather(testCityName)).thenAnswer((_) async => const Right(testWeatherDetail));

    final result = await getCurrentWeatherUseCase.execute(testCityName);
    expect(result, const Right(testWeatherDetail));
  });
}
