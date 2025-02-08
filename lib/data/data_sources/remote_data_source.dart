import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataaSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataaSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
