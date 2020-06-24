import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../data/model/beer.dart';
import '../bloc/bloc.dart';

class BeerListPage extends StatefulWidget {
  BeerListPage({Key key}) : super(key: key);

  @override
  _BeerListPageState createState() => _BeerListPageState();
}

class _BeerListPageState extends State<BeerListPage> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getBeerByName(context, "test");
    return Scaffold(
      appBar: AppBar(
        title: Text("Beer List"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<BeerBloc, BeerState>(
          builder: (BuildContext context, BeerState state) {
            if (state is BeerLoading) {
              return buildLoading();
            } else {
              data = (state as BeerLoaded).data['beers'];
              print("i am here");
              return buildBeerLoaded();
            }
          },
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
      child: Text("loading time"),
      // child: CircularProgressIndicator(),
    );
  }

  Widget buildBeerLoaded() {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var item = data[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(item['name']),
              // title: Text(item['name']),
              // trailing: Container(
              //   padding: EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //     color: item['status'] == 'Dead'
              //         ? Colors.red.withOpacity(0.3)
              //         : item['status'] == 'Alive'
              //             ? Colors.green.withOpacity(0.3)
              //             : Colors.amber.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(32.0),
              //   ),
              //   child: Text(
              //     item['status'],
              //     style: TextStyle(
              //         color: item['status'] == 'Dead'
              //             ? Colors.red
              //             : item['status'] == 'Alive'
              //                 ? Colors.green
              //                 : Colors.amber),
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }
}

// void getBeerByName(BuildContext context, String beerName) {
//   final beerBloc = BlocProvider.of<BeerBloc>(context);
//   beerBloc.add(GetBeer(beerName));
// }
