import 'dart:io';

import 'package:assessment_bcg_telkomsel/presenter/player/player_event.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({this.audioPlayer}) : super(PlayerInitial());

  final AudioPlayer audioPlayer;

  bool isPlaying(int trackId) {
    if (state is PlayerLoaded) {
      PlayerLoaded playerState = state;
      return playerState.controllerState == ControllerState.playing &&
          playerState.selectedTrack.trackId == trackId;
    }
    return false;
  }

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    final currentState = state;

    if (event is LoadTrack) {
      // handle mock for unit test
      if (audioPlayer == null) {
        yield PlayerLoaded(
            controllerState: ControllerState.playing,
            maxDuration: 999,
            selectedTrack: event.track);
        return;
      }

      await audioPlayer.play(event.track.previewUrl);
      if (Platform.isAndroid) {
        await Future.delayed(Duration(milliseconds: 369));
      }
      final duration = await audioPlayer.getDuration();
      print(
          'duration of ${event.track.trackId} ${event.track.trackName} is $duration ms');
      yield PlayerLoaded(
          controllerState: ControllerState.playing,
          maxDuration: duration,
          selectedTrack: event.track);
    }

    if (event is StopTrack) {
      await audioPlayer.stop();
      yield PlayerInitial();
    }

    if (event is PauseResumeTrack) {
      if (currentState is PlayerLoaded) {
        if (currentState.controllerState == ControllerState.playing) {
          await audioPlayer.pause();
          yield currentState.copyWith(controllerState: ControllerState.paused);
        } else {
          await audioPlayer.resume();
          yield currentState.copyWith(controllerState: ControllerState.playing);
        }
      }
    }
  }
}
