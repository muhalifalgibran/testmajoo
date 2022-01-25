import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/presentation/extra/error_screen.dart';
import 'package:majootestcase/presentation/extra/loading.dart';
import 'package:majootestcase/presentation/home_bloc/home_detail_screen.dart';
import '../../bloc/home_bloc/home_bloc_cubit.dart';
import 'home_bloc_loaded_screen.dart';

class HomeBlocScreen extends StatelessWidget {
  const HomeBlocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocCubit, HomeBlocState>(builder: (context, state) {
      if (state is HomeBlocLoadedState) {
        return HomeBlocLoadedScreen(data: state.data);
      } else if (state is HomeBlocLoadingState) {
        return LoadingIndicator();
      } else if (state is HomeBlocInitialState) {
        return Scaffold();
      } else if (state is HomeBlocErrorState) {
        return ErrorScreen(
          message: state.error,
          retry: () => _retry(context),
        );
      } else if (state is HomeDetailMovieState) {
        return HomeDetailScreen(
          data: state.data,
        );
      }

      return Center(
          child: Text(kDebugMode ? "state not implemented $state" : ""));
    });
  }

  _retry(context) {
    BlocProvider.of<HomeBlocCubit>(context).retryConnection();
  }
}
