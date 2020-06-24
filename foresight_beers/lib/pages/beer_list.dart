import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/beer.dart';
import '../bloc/bloc.dart';

class BeerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getBeerByName(context, "test");
    return Scaffold(
      appBar: AppBar(
        title: Text("Beer List"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<BeerBloc, BeerState>(
          listener: (context, state) {
            // if (state is WeatherError) {
            //   Scaffold.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text(state.message),
            //     ),
            //   );
            // }
          },
          child: BlocBuilder<BeerBloc, BeerState>(
            builder: (context, state) {
              if (state is BeerInitial) {
                return buildInitial();
              } else if (state is BeerLoading) {
                return buildLoading();
              } else if (state is BeerLoaded) {
                return buildColumnWithData(context, state.beer);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitial() {
    return Center(
      child: new Text("initial page"),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Beer beer) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          beer.beerName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "beer loaded",
          style: TextStyle(fontSize: 80),
        ),
        // RaisedButton(
        //   child: Text('See Details'),
        //   color: Colors.lightBlue[100],
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (_) => BlocProvider.value(
        //           value: BlocProvider.of<WeatherBloc>(context),
        //           child: WeatherDetailPage(
        //             masterWeather: weather,
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}

void getBeerByName(BuildContext context, String beerName) {
  final beerBloc = BlocProvider.of<BeerBloc>(context);
  beerBloc.add(GetBeer(beerName));
}
