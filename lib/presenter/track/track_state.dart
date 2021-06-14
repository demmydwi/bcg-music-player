import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:equatable/equatable.dart';

abstract class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

class TrackInitial extends TrackState {}

class TrackLoading extends TrackState {}

class TrackFailure extends TrackState {}

class TrackLoaded extends TrackState {
  final List<TrackData> tracks;
  final String query;

  const TrackLoaded({
    this.tracks,
    this.query,
  });

  @override
  List<Object> get props => [tracks, query];

  @override
  String toString() => 'TrackSuccess { tracks: ${tracks.length}}';
}
