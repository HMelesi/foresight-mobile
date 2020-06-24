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
    }
  }
''';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
