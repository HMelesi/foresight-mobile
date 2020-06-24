import 'package:equatable/equatable.dart';

abstract class BeerEvent extends Equatable {
  const BeerEvent();
}

class GetBeer extends BeerEvent {
  final String beerName;

  const GetBeer(this.beerName);

  @override
  List<Object> get props => [beerName];
}
