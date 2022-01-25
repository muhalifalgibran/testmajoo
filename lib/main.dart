import 'package:majootestcase/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:majootestcase/presentation/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/presentation/login/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:majootestcase/utils/database_locator.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';

import 'bloc/main_bloc/main_bloc_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: _scaffoldKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) => MainBlocCubit()..fetchHistoryLogin(),
          child: MyHomePageScreen(),
        ));
  }
}

class MyHomePageScreen extends StatelessWidget {
  const MyHomePageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBlocCubit, MainBlocState>(
      listener: (context, state) {
        print(state);
        if (state is MainInitialState) {
          return BlocProvider(
            create: (context) => AuthBlocCubit(),
            child: LoginPage(),
          );
        } else if (state is MainLogginState) {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => AuthBlocCubit(),
                child: LoginPage(),
              ),
            ),
          );
        } else if (state is MainIsLoggedInstate) {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => HomeBlocCubit()..fetchingData(),
                child: HomeBlocScreen(),
              ),
            ),
          );
        }
      },
      child: Scaffold(),
    );
  }
}
