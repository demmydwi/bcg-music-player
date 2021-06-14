import 'package:flutter/material.dart';

class TrackItemView extends StatefulWidget {
  final String imageUrl, song, album, artist;

  final bool isPlaying;

  const TrackItemView(
      {Key key,
      this.imageUrl,
      this.song,
      this.album,
      this.artist,
      this.isPlaying = false})
      : super(key: key);

  @override
  _TrackItemViewState createState() => _TrackItemViewState();
}

class _TrackItemViewState extends State<TrackItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, top: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff22254D).withOpacity(0.6)),
      child: content,
    );
  }

  Widget get content => Row(
        children: [
          Image.network(
            widget.imageUrl,
            height: 76,
            width: 76,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(child: body),
        ],
      );

  Widget get body => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          Text(
            widget.song,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            widget.album,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    widget.artist ?? 'Bruno Mars',
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                indicator
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      );

  Widget get indicator => widget.isPlaying
      ? Image.network(
          'https://media.giphy.com/media/8OdHBvuKmZCwtxb7rX/giphy.gif',
          height: double.infinity,
          fit: BoxFit.fitHeight,
        )
      : SizedBox.shrink();
}
