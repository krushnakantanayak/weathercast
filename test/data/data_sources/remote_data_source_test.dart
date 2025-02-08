import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/data/data_sources/remote_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });
  const testCityname = 'New York';
  group('get current Weather', () {
    test('return Weather model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityname)))).thenAnswer((_) async => http.Response(readJson('helpers/dummy_data/dummy_weather_response.json'), 200));
      // act

      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityname);
      // assert

      expect(result, isA<WeatherModel>());
    });
    test(
      'throw a server exception when the response code is 404 or other ',
      () async {
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityname))),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        final result = weatherRemoteDataSourceImpl.getCurrentWeather(testCityname);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
