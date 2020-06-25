import 'package:equatable/equatable.dart';

abstract class BeerEvent extends Equatable {
  const BeerEvent();

  @override
  List<Object> get props => [];
}

class GetBeer extends BeerEvent {
  final String query;
  final Map<String, dynamic> variables;

  const GetBeer(this.query, {this.variables});

  @override
  List<Object> get props => [query, variables];
}
