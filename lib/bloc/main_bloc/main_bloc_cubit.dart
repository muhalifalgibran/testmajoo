import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/main_bloc/main_bloc_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBlocCubit extends Cubit<MainBlocState> {
  MainBlocCubit() : super(MainInitialState());

  void fetchHistoryLogin() async {
    emit(MainInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool("is_logged_in");
    if (isLoggedIn == null) {
      emit(MainLogginState());
    } else {
      if (isLoggedIn) {
        emit(MainIsLoggedInstate());
      } else {
        emit(MainLogginState());
      }
    }
  }
}
