import 'package:equatable/equatable.dart';

abstract class TrackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTrack extends TrackEvent {

  final String query;

  FetchTrack({
    this.query,
  });

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'FetchTrack { query: $query}}';
}