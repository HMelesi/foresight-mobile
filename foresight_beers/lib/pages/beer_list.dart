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
  final BeerBloc _beerBloc = BeerBloc();

  List data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange[400],
          title: Text(
            "craft beer list",
            style: TextStyle(
              fontFamily: 'Lobster Two',
              color: Colors.white,
              fontSize: 28,
            ),
          ),
        ),
        body: BlocProvider<BeerBloc>(
          create: (BuildContext context) => _beerBloc..add(GetBeer(query)),
          child: Column(
            children: <Widget>[
              buildButton(),
              Expanded(
                child: BlocBuilder<BeerBloc, BeerState>(
                  builder: (BuildContext context, BeerState state) {
                    if (state is BeerLoading) {
                      return buildLoading();
                    } else {
                      data = (state as BeerLoaded).data['beers'];
                      return buildBeerLoaded();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        child: Icon(Icons.refresh, color: Colors.white),
        color: Colors.deepOrange[200],
        onPressed: () {
          refreshBeerList(context, query);
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBeerLoaded() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'TOTAL BEERS: ${data.length}',
            style: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
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
                    color: Colors.deepOrange[200],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Text(item['name'],
                        style: TextStyle(
                          fontFamily: 'Lobster Two',
                          color: Colors.deepOrange[600],
                          fontSize: 26,
                        )),
                    Text(item['type'],
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: 16,
                        )),
                    Text(item['brewery'],
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: 22,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('ABV: ${percentformatter.format(item['abv'])}',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.deepOrange[600],
                                  fontSize: 18,
                                )),
                            Text('Release Date: ${(item['released'])}',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.deepOrange[600],
                                  fontSize: 18,
                                )),
                          ]),
                    )
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
    _beerBloc.add(GetBeer(query));
  }
}
