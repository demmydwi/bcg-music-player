import 'package:assessment_bcg_telkomsel/presenter/bloc.dart';
import 'package:assessment_bcg_telkomsel/presenter/bloc/observer.dart';
import 'package:assessment_bcg_telkomsel/presenter/player/player_bloc.dart';
import 'package:assessment_bcg_telkomsel/presenter/progress/progress_bloc.dart';
import 'package:assessment_bcg_telkomsel/view/home_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presenter/track/track_repo.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TracksBloc>(
          create: (_) => TracksBloc(repository: TrackRepository()),
        ),
        BlocProvider<PlayerBloc>(
          create: (_) => PlayerBloc(audioPlayer: AudioPlayer()),
        ),
        BlocProvider<ProgressBloc>(
          create: (_) => ProgressBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'BCG Music Player',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
