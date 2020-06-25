import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/bloc.dart';

class BeerListPage extends StatefulWidget {
  BeerListPage({Key key}) : super(key: key);

  @override
  _BeerListPageState createState() => _BeerListPageState();
}

class _BeerListPageState extends State<BeerListPage> {
  final String query = r'''
  {
    beers {
    name
    type
    abv
    brewery
    description
    mash
    hops
    released
  }
  }
  ''';

  final percentformatter = new NumberFormat("##.##%");
  final dateformatter = new DateFormat.yMMMd();
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink[100],
        title: Text("Top Craft Beers in England"),
      ),
      body: Column(
        children: <Widget>[
          buildButton(),
          Expanded(
            child: BlocListener<BeerBloc, BeerState>(
              listener: (context, state) {
                if (state is BeerLoaded) {
                  print('i am listening');
                }
              },
              child: BlocBuilder<BeerBloc, BeerState>(
                builder: (BuildContext context, BeerState state) {
                  if (state is BeerLoading) {
                    return buildLoading();
                  } else {
                    print('trying to read data');
                    data = (state as BeerLoaded).data['beers'];
                    return buildBeerLoaded(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return RaisedButton(
      child: Icon(Icons.refresh),
      onPressed: () {
        print('pressed button');
        refreshBeerList(context, query);
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBeerLoaded(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'These are the ${data.length} top beers in England according to Untappd'),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            var item = data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.pink[300],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Text(item['name']),
                    Text(item['type']),
                    Text(item['brewery']),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('ABV: ${percentformatter.format(item['abv'])}'),
                          Text('Release Date: ${(item['released'])}'),
                        ])
                  ], crossAxisAlignment: CrossAxisAlignment.start),
                ),
              ),
            );
          },
        )),
      ],
    );
  }

  void refreshBeerList(BuildContext context, String query) {
    final beerBloc = BlocProvider.of<BeerBloc>(context);
    beerBloc.add(GetBeer(query));
  }
}
