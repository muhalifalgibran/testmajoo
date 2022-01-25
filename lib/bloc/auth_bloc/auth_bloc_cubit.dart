import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/data/models/user.dart';
import 'package:majootestcase/utils/database_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetchHistoryLogin() async {
    emit(AuthBlocInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool("is_logged_in");
    if (isLoggedIn == null) {
      print('assd1');

      emit(AuthBlocLoginState());
    } else {
      if (isLoggedIn) {
        print('assd');

        emit(AuthBlocLoggedInState());
      } else {
        print('asd');
        emit(AuthBlocLoginState());
      }
    }
  }

  void loginUser(User user) async {
    emit(AuthBlocLoadingState());
    List<User> users = await DatabaseLocator.instance.getUser();
    for (var x in users) {
      if (x.email == user.email && x.password == user.password) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setBool("is_logged_in", true);
        String data = user.toJson().toString();
        sharedPreferences.setString("user_value", data);
        emit(AuthBlocLoggedInState());
        print('this');
        return;
      }
    }

    emit(AuthBlocFailedToLogginState());
    print('this 2');
  }

  void getUser() async {
    List<User> users = await DatabaseLocator.instance.getUser();
    users.forEach((element) {
      print(element.userName);
    });
  }

  addUser(User user) async {
    emit(AuthBlocLoadingState());
    await DatabaseLocator.instance.addUser(user);
    emit(AuthBlocLoadedState(user));
  }

  moveToRegister() {
    emit(AuthRegisterState());
  }
}
