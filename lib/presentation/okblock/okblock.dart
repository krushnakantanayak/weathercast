import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/usecase/get_current_weather.dart';
import 'package:weather/presentation/okblock/okblock_event.dart';
import 'package:weather/presentation/okblock/okblock_state.dart';

class OkBloc extends Bloc<OkblocEvent, OkblocState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  OkBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnTest>((event, emit) async {
      await Future.delayed(const Duration(seconds: 10));
      emit(WeatherOk());
      await Future.delayed(const Duration(seconds: 7));
      emit(WeatherDone());
    });
  }
}
