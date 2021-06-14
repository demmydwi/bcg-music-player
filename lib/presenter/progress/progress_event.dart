import 'package:equatable/equatable.dart';

abstract class ProgressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProgress extends ProgressEvent {
  final int position;

  UpdateProgress({
    this.position,
  });

  @override
  List<Object> get props => [
        position,
      ];

  @override
  String toString() => 'Update Progress { position: $position}}';
}
