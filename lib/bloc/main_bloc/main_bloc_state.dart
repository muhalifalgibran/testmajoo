import 'package:equatable/equatable.dart';

abstract class MainBlocState extends Equatable {
  const MainBlocState();

  @override
  List<Object> get props => [];
}

class MainIsLoggedInstate extends MainBlocState {}

class MainLogginState extends MainBlocState {}

class MainInitialState extends MainBlocState {}
