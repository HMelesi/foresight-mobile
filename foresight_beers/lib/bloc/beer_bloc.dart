import 'dart:async';
import './bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/graphql_service.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  GraphQLService service;

  BeerBloc() {
    service = GraphQLService();
  }

  @override
  BeerState get initialState => BeerLoading();

  @override
  Stream<BeerState> mapEventToState(BeerEvent event) async* {
    if (event is GetBeer) {
      yield* _mapGetBeerToState(event);
    }
  }

  Stream<BeerState> _mapGetBeerToState(GetBeer event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      final result = await service.performQuery(query, variables: variables);

      if (result.hasException) {
        print('ERROR TIME');
      } else {
        yield BeerLoaded(result.data);
      }
    } catch (e) {
      print(e);
      // yield LoadDataFail(e.toString());
    }
  }
}
