import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/domain/usecase/get_current_weather.dart';
import 'package:weather/presentation/block/weather_event.dart';
import 'package:weather/presentation/block/weather_state.dart';

class WeatherBlock extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBlock(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase.execute(event.cityName);
        result.fold(
          (failure) {
            emit(WeatherLoadFailue(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
        // await Future.delayed(const Duration(seconds: 10));
        // emit(WeatherDone());
        // await Future.delayed(const Duration(seconds: 2));
        // emit(WeatherOk());
      },
      transformer: debounce(const Duration(microseconds: 500)),
    );
    // on<OnTest>((event, emit) async {
    //   emit(WeatherLoading());
    //   await Future.delayed(const Duration(seconds: 2));
    //   emit(WeatherOk());
    // });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return ((events, mapper) => events.debounceTime(duration).flatMap((mapper)));
}
