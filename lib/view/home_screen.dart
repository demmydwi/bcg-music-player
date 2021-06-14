import 'dart:async';
import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:assessment_bcg_telkomsel/presenter/bloc.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_bloc.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_event.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_state.dart';
import 'package:assessment_bcg_telkomsel/view/player_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlayerBloc playerBloc;

  // keyboard
  Timer _typingTimer;
  final int _typingDebounce = 650;

  // player
  Timer _playerTimer;
  final int _playerDebounce = 250;

  @override
  void initState() {
    super.initState();
    _listenAudioPlayer();
  }

  @override
  void dispose() {
    playerBloc.close();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_typingTimer?.isActive ?? false) _typingTimer.cancel();
    _typingTimer = Timer(Duration(milliseconds: _typingDebounce), () {
      if (query.isNotEmpty) {
        BlocProvider.of<TracksBloc>(context).add(FetchTrack(query: query));
      }
    });
  }

  _listenAudioPlayer() {
    setState(() {
      playerBloc = BlocProvider.of<PlayerBloc>(context);
    });
    playerBloc.audioPlayer.onAudioPositionChanged.listen((event) {
      BlocProvider.of<ProgressBloc>(context)
          .add(UpdateProgress(position: event.inMilliseconds));
    });
    playerBloc.audioPlayer.onPlayerCompletion.listen((event) {
      if (playerBloc.state is PlayerLoaded) {
        playerBloc.add(StopTrack());
      }
    });
  }

  _togglePauseResume() async {
    playerBloc.add(PauseResumeTrack());
  }

  _play({TrackData track}) async {
    playerBloc.add(LoadTrack(
      track: track,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff16161d),
      body: Column(
        children: [
          Expanded(
              child: SafeArea(
            bottom: false,
            child: content,
          )),
          player
        ],
      ),
    );
  }

  Widget get content => Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          children: [
            header,
            SizedBox(
              height: 16,
            ),
            body,
          ],
        ),
      );

  Widget get body => Expanded(child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (_, playerState) {
          return BlocListener<TracksBloc, TrackState>(
            listener: (_, state) {
              if (state is TrackLoaded) {
                FocusScope.of(context).unfocus();
              }
            },
            child: BlocBuilder<TracksBloc, TrackState>(
              builder: (context, state) {
                if (state is TrackLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TrackLoaded) {
                  return loadedBody(state.tracks);
                }
                return Center(
                  child: Text(
                    'There is no Tracks found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          );
        },
      ));

  Widget loadedBody(List<TrackData> tracks) {
    return ListView(
      children: tracks.map((TrackData e) {
        return GestureDetector(
          onTap: () {
            if (playerBloc.isPlaying(e.trackId)) {
              _togglePauseResume();
            } else {
              _play(track: e);
            }
          },
          child: TrackItemView(
            song: e.trackName,
            artist: e.artistName,
            album: e.collectionName,
            imageUrl: e.artworkUrl,
            isPlaying: playerBloc.isPlaying(e.trackId),
          ),
        );
      }).toList(),
    );
  }

  Widget get player =>
      BlocBuilder<PlayerBloc, PlayerState>(builder: (_, state) {
        if (state is PlayerLoaded) {
          return Container(
            height: 150,
            color: Color(0xff16161d),
            width: double.infinity,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerView(
                  track: state.selectedTrack,
                  isPlaying: state.controllerState == ControllerState.playing,
                  onTogglePauseResume: _togglePauseResume,
                ),
                buildSlider(
                    track: state.selectedTrack, maxDuration: state.maxDuration)
              ],
            ),
          );
        }
        return SizedBox.shrink();
      });

  Widget buildSlider({TrackData track, int maxDuration}) =>
      BlocBuilder<ProgressBloc, ProgressState>(
        builder: (_, state) {
          if (state is ProgressLoaded) {
            return Slider(
              min: 0,
              activeColor: Colors.white,
              inactiveColor: Colors.white12,
              max: maxDuration.toDouble(),
              onChanged: (a) async {
                BlocProvider.of<ProgressBloc>(context)
                    .add(UpdateProgress(position: a.toInt()));

                if (playerBloc.isPlaying(track.trackId)) {
                  _togglePauseResume();
                }
                if (_playerTimer?.isActive ?? false) _playerTimer.cancel();
                _playerTimer =
                    Timer(Duration(milliseconds: _playerDebounce), () async {
                  await playerBloc.audioPlayer
                      .seek(Duration(milliseconds: a.toInt()));
                  if (!playerBloc.isPlaying(track.trackId)) {
                    _togglePauseResume();
                  }
                });
              },
              value: state.position.toDouble(),
            );
          }
          return SizedBox.shrink();
        },
      );

  Widget get header => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello !',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'What you want to hear today',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 0.5),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff22254D).withOpacity(0.7)),
            child: searchBox,
          ),
        ],
      );

  Widget get searchBox => Row(
        children: [
          Icon(
            CupertinoIcons.search,
            color: Colors.white70,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextField(
            style: TextStyle(color: Colors.white),
            onChanged: _onSearchChanged,
            autocorrect: false,
            enableSuggestions: true,
            decoration: InputDecoration.collapsed(
                    hintText: 'Search Music or Artist',
                    hintStyle: TextStyle(color: Colors.white54))
                .copyWith(),
          ))
        ],
      );
}
