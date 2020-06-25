import 'dart:async';
import './bloc.dart';
import 'package:bloc/bloc.dart';
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
      print('in event not mapped');
      yield* _mapGetBeerToState(event);
    }
  }

  Stream<BeerState> _mapGetBeerToState(GetBeer event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      print('mapping event');
      final result = await service.performMutation(query, variables: variables);

      if (result.hasException) {
        print('ERROR TIME');
      } else {
        print(result.data);
        print("ready to send");
        yield BeerLoaded(result.data);
      }
    } catch (e) {
      print(e);
    }
  }
}
