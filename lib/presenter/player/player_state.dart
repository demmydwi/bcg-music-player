import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:equatable/equatable.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

enum ControllerState { playing, paused, stopped }

class PlayerInitial extends PlayerState {}

class PlayerLoaded extends PlayerState {

  final ControllerState controllerState;

  final TrackData selectedTrack;

  final int maxDuration;

  const PlayerLoaded({
    this.selectedTrack,
    this.maxDuration,
    this.controllerState,
  });

  PlayerLoaded copyWith({
    int value,
    TrackData selectedTrack,
    int maxDuration,
    ControllerState controllerState,
  }) {
    return PlayerLoaded(
      maxDuration: maxDuration ?? this.maxDuration,
      selectedTrack: selectedTrack ?? this.selectedTrack,
      controllerState: controllerState ?? this.controllerState,
    );
  }

  @override
  List<Object> get props => [
        this.selectedTrack,
        this.maxDuration,
        this.controllerState,
      ];

  @override
  String toString() => 'PlayerPlaying { Player: ${selectedTrack?.trackId}}';
}
