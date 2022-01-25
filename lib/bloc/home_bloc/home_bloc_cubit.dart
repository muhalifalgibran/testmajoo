import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/data/models/movie_response.dart';
import 'package:majootestcase/services/api_service.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  HomeBlocCubit() : super(HomeBlocInitialState());

  void fetchingData() async {
    emit(HomeBlocInitialState());
    ApiServices apiServices = ApiServices();
    MovieResponse? movieResponse = await apiServices.getMovieList();
    if (movieResponse == null) {
      emit(HomeBlocErrorState(
        "Error Unknown",
      ));
    } else {
      emit(HomeBlocLoadedState(movieResponse.data ?? []));
    }
  }

  void retryConnection() async {
    ApiServices apiServices = ApiServices();
    MovieResponse? movieResponse = await apiServices.getMovieList();
    if (movieResponse == null) {
      emit(HomeBlocErrorState(
        "Error Unknown",
      ));
    } else {
      emit(HomeBlocLoadedState(movieResponse.data ?? []));
    }
  }

  void getDetailMovie(Data data) async {
    emit(HomeDetailMovieState(data));
  }
}
