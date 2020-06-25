import 'package:equatable/equatable.dart';

abstract class BeerState extends Equatable {
  const BeerState();
  @override
  List<Object> get props => [];
}

class BeerLoading extends BeerState {
  const BeerLoading();
  @override
  List<Object> get props => [];
}

class BeerLoaded extends BeerState {
  final dynamic data;
  const BeerLoaded(this.data);
  @override
  List<Object> get props => [data];
}
