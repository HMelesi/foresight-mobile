import 'dart:async';
import './bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/model/beer.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  @override
  BeerState get initialState => BeerInitial();

  @override
  Stream<BeerState> mapEventToState(
    BeerEvent event,
  ) async* {
    yield BeerLoading();
    if (event is GetBeer) {
      try {
        print("sending a get request");
        // is this where you make graphql call?
        final beer = Beer(beerName: "testbeer");
        yield BeerLoaded(beer);
      } finally {
        print("maybe catch an error here");
      }
    }
    // TODO: implement mapEventToState
  }
}
