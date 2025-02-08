import 'package:equatable/equatable.dart';

abstract class OkblocState extends Equatable {
  const OkblocState();
  @override
  List<Object> get props => [];
}

class WeatherEmpty extends OkblocState {}

class WeatherOk extends OkblocState {}

class WeatherDone extends OkblocState {}
