import 'package:equatable/equatable.dart';

abstract class OkblocEvent extends Equatable {
  const OkblocEvent();
  @override
  List<Object> get props => [];
}

// event
class OnTest extends OkblocEvent {}
