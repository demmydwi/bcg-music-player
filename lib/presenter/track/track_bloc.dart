import 'package:assessment_bcg_telkomsel/presenter/track/track_event.dart';
import 'package:assessment_bcg_telkomsel/presenter/track/track_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'track_repo.dart';

class TracksBloc extends Bloc<TrackEvent, TrackState> {
  TracksBloc({@required this.repository})
      : assert(repository != null),
        super(TrackInitial());

  final ImplTrackRepository repository;

  @override
  Stream<TrackState> mapEventToState(TrackEvent event) async* {
    final currentState = state;

    if (event is FetchTrack) {
      bool shouldRequest = currentState is! TrackLoaded ||
          (currentState is TrackLoaded && currentState.query != event.query);
      if (shouldRequest) {
        yield TrackLoading();
        try {
          final apiResponse = await repository.searchBy(event.query);
          yield TrackLoaded(
              query: event.query, tracks: apiResponse.filteredResult);
        } catch (e) {
          yield TrackFailure();
        }
      }
    }
  }
}
