import '../data/model/beer.dart';
import 'package:equatable/equatable.dart';

abstract class BeerState extends Equatable {
  const BeerState();
}

class BeerInitial extends BeerState {
  const BeerInitial();
  @override
  List<Object> get props => [];
}

class BeerLoading extends BeerState {
  const BeerLoading();
  @override
  List<Object> get props => [];
}

class BeerLoaded extends BeerState {
  final Beer beer;
  const BeerLoaded(this.beer);
  @override
  List<Object> get props => [beer];
}
