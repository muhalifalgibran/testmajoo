part of 'auth_bloc_cubit.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthBlocInitialState extends AuthBlocState {}

class AuthBlocLoadingState extends AuthBlocState {
  const AuthBlocLoadingState();
}

class AuthBlocLoggedInState extends AuthBlocState {}

class AuthBlocFailedToLogginState extends AuthBlocState {}

class AuthBlocLoginState extends AuthBlocState {}

class AuthRegisterState extends AuthBlocState {
  const AuthRegisterState();
}

class AuthBlocSuccesState extends AuthBlocState {}

class AuthBlocLoadedState extends AuthBlocState {
  final data;

  AuthBlocLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class AuthBlocErrorState extends AuthBlocState {
  final error;

  AuthBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}
