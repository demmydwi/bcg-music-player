import 'dart:io';

import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:assessment_bcg_telkomsel/presenter/bloc.dart';
import 'package:assessment_bcg_telkomsel/presenter/mock_track_repo.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_bloc.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_event.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Track bloc test', () {
    TracksBloc tracksBloc;
    MockTrackRepository repository;

    setUp(() {
      repository = MockTrackRepository();
      tracksBloc = TracksBloc(repository: repository);
    });

    final mockQuery = 'queries';

    blocTest<TracksBloc, TrackState>(
      'Test track bloc and states',
      build: () => tracksBloc,
      act: (bloc) => bloc.add(FetchTrack(query: mockQuery)),
      expect: [
        TrackLoading(),
        TrackLoaded(tracks: mockResponse.results, query: mockQuery),
      ],
    );

    tearDown(() {
      tracksBloc?.close();
    });
  });

  group('Progress bloc test', () {
    ProgressBloc progressBloc;

    setUp(() {
      progressBloc = ProgressBloc();
    });

    final int playAt = 5; // any number

    blocTest<ProgressBloc, ProgressState>(
      'Test progress bloc and states',
      build: () => progressBloc,
      act: (bloc) => bloc.add(UpdateProgress(position: playAt)),
      expect: [
        ProgressLoaded(position: playAt),
      ],
    );

    tearDown(() {
      progressBloc?.close();
    });
  });

  group('Player bloc test', () {
    PlayerBloc playerBloc;

    setUp(() {
      playerBloc = PlayerBloc();
    });

    final mockSelectedTrack = mockResponse.results.first;

    blocTest<PlayerBloc, PlayerState>(
      'Test player bloc and states ',
      build: () => playerBloc,
      act: (bloc) => bloc.add(LoadTrack(track: mockSelectedTrack)),
      expect: [
        PlayerLoaded(
            controllerState: ControllerState.playing,
            maxDuration: 999,
            selectedTrack: mockSelectedTrack)
      ],
    );

    tearDown(() {
      playerBloc?.close();
    });
  });

}
