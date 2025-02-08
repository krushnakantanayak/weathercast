import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/presentation/block/weather_block.dart';
import 'package:weather/presentation/block/weather_event.dart';
import 'package:weather/presentation/block/weather_state.dart';
import 'package:weather/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState> implements WeatherBlock {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null; //doubt
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBlock>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  testWidgets(
    ' State to change from empty to loading',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField); //doubt
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();
      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    ' show progress indicator when state is loading',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    ' widget contain weather data ',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(const WeatherLoaded(testWeather));

      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      expect(find.byKey(const Key('weather_data')), findsOneWidget); //doubt
    },
  );
}
