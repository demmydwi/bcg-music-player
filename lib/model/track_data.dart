import 'package:equatable/equatable.dart';

class TrackData extends Equatable {
  int artistId;
  int collectionId;
  int trackId;
  String artistName;
  String collectionName;
  String trackName;
  String previewUrl;
  String artworkUrl60;
  String get artworkUrl => artworkUrl60.replaceAll('60x60bb', '200x200bb');

  TrackData({
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.previewUrl,
    this.artworkUrl60,
  });

  TrackData.fromJson(Map<String, dynamic> json) {
    artistId = json['artistId'];
    collectionId = json['collectionId'];
    trackId = json['trackId'];
    artistName = json['artistName'];
    collectionName = json['collectionName'];
    trackName = json['trackName'];
    previewUrl = json['previewUrl'];
    artworkUrl60 = json['artworkUrl60'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artistId'] = this.artistId;
    data['collectionId'] = this.collectionId;
    data['trackId'] = this.trackId;
    data['artistName'] = this.artistName;
    data['collectionName'] = this.collectionName;
    data['trackName'] = this.trackName;
    data['previewUrl'] = this.previewUrl;
    data['artworkUrl60'] = this.artworkUrl60;
    return data;
  }

  @override
  List<Object> get props => [trackId, collectionId, artistId];
}
