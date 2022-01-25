import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/data/models/movie_response.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final List<Data> data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return movieItemWidget(data[index], context);
          },
        ),
      ),
    );
  }

  Widget movieItemWidget(Data data, context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeBlocCubit>(context).getDetailMovie(data);
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                data.l,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.network(data.i.imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}
