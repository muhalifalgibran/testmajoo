part of 'home_bloc_cubit.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitialState extends HomeBlocState {}

class HomeBlocLoadingState extends HomeBlocState {}

class HomeDetailMovieState extends HomeBlocState {
  final Data data;
  HomeDetailMovieState(this.data);
  @override
  List<Object> get props => [data];
}

class HomeBlocLoadedState extends HomeBlocState {
  final List<Data> data;
  HomeBlocLoadedState(this.data);
  @override
  List<Object> get props => [data];
}

class HomeBlocErrorState extends HomeBlocState {
  final error;

  HomeBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}
