import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/weather.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );
  test("WeatherModel is a sub class of Weatherentities", () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test("json return the valid WeatherModel", () async {
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );
    final result = WeatherModel.fromJson(jsonMap);
    expect(result, equals(testWeatherModel));
  });

  test(
    "json return the proper data or not ",
    () async {
      final result = testWeatherModel.toJson();
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };
      expect(result, equals(expectedJsonMap));
    },
  );
}
