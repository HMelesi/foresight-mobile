import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Beer extends Equatable {
  final String beerName;

  Beer({
    @required this.beerName,
  });

  @override
  List<Object> get props => [
        beerName,
      ];
}
