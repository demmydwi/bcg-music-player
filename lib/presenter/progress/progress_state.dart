import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:equatable/equatable.dart';

abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoaded extends ProgressState {

  final int position;

  const ProgressLoaded({
    this.position,
  });

  ProgressLoaded copyWith({
    bool isPlaying,
    int value,
    TrackData selectedTrack,
    int maxDuration
  }) {
    return ProgressLoaded(
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [
        this.position,
      ];

  @override
  String toString() =>
      'ProgressLoaded { Progress: $position}';
}
