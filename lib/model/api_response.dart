import 'package:assessment_bcg_telkomsel/model/track_data.dart';

class ApiResponse {
  int resultCount;
  List<TrackData> results;
  List<TrackData> get filteredResult => results
      .where((element) =>
          element.previewUrl != null &&
          !element.previewUrl.contains('?uo=4') &&
          element.artistName != null &&
          element.trackName != null &&
          element.collectionName != null &&
          element.artworkUrl60 != null)
      .toList();

  ApiResponse({this.resultCount, this.results});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    resultCount = json['resultCount'];
    if (json['results'] != null) {
      results = List<TrackData>();
      json['results'].forEach((v) {
        results.add(TrackData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resultCount'] = this.resultCount;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
