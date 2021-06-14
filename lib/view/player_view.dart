import 'package:assessment_bcg_telkomsel/model/track_data.dart';
import 'package:flutter/material.dart';

class PlayerView extends StatelessWidget {
  final TrackData track;

  final bool isPlaying;

  final VoidCallback onTogglePauseResume;

  PlayerView({Key key, this.track, this.isPlaying, this.onTogglePauseResume}) : super(key: key);

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Image.network(
              track.artworkUrl,
              height: 76,
              width: 76,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(child: body),
            button
          ],
        ));
  }

  Widget get body => Container(
        height: 76,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2,
            ),
            Text(
              track.trackName,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              track.collectionName,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
            Expanded(child: SizedBox.shrink()),
            Text(
              track.artistName,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      );

  Widget get button => InkWell(
        onTap: onTogglePauseResume,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(left: 12, right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white)),
          child: isPlaying
              ? Icon(
                  Icons.pause,
                  size: 24,
                  color: Colors.white,
                )
              : Icon(
                  Icons.play_arrow_outlined,
                  size: 24,
                  color: Colors.white,
                ),
        ),
      );
}
