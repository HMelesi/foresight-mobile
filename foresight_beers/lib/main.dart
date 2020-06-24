import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './simple_delegate.dart';
import 'bloc/bloc.dart';
import 'pages/beer_list.dart';

void main() {
  BlocSupervisor.delegate = MySimpleBlocDelegate();

  runApp(MyApp());
}

String query = r'''
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer App',
      home: BlocProvider<BeerBloc>(
        create: (BuildContext context) => BeerBloc()..add(GetBeer(query)),
        child: BeerListPage(),
      ),
    );
  }
}
