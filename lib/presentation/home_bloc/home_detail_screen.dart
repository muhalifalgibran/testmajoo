import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/data/models/movie_response.dart';

class HomeDetailScreen extends StatelessWidget {
  final Data? data;
  const HomeDetailScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeBlocCubit, HomeBlocState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<HomeBlocCubit>(context)..fetchingData();
            return true;
          },
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    data?.i?.imageUrl ?? '',
                    height: 200,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    data?.l ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    data!.year.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Text(
                  'Series: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data?.series?.length ?? 0,
                    itemBuilder: (context, index) {
                      return movieSeries(data!.series![index], context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }

  Widget movieSeries(Series seri, BuildContext context) {
    return Stack(
      children: [
        Image.network(seri.i?.imageUrl ?? ''),
        Center(
          child: Text(
            seri.l ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
