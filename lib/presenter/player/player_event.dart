import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StopTrack extends PlayerEvent {}

class PauseResumeTrack extends PlayerEvent {}

class SeekTrack extends PlayerEvent {
  final int position;

  SeekTrack({
    this.position,
  });

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'Seek { position: $position}}';
}

class LoadTrack extends PlayerEvent {
  final TrackData track;

  LoadTrack({
    this.track,
  });

  @override
  List<Object> get props => [
        track,
      ];

  @override
  String toString() => 'PlayTrack { track: $track}}';
}
