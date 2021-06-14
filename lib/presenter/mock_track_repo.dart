import 'package:assessment_bcg_telkomsel/model/api_response.dart';
import 'package:assessment_bcg_telkomsel/presenter/track/track_repo.dart';

class MockTrackRepository implements TrackRepository {

  @override
  Future<ApiResponse> searchBy(String query) {
    return Future.delayed(Duration(seconds: 2), () => mockResponse);
  }
}

final ApiResponse mockResponse = ApiResponse.fromJson({
  "resultCount": 3,
  "results": [
    {
      "artistId": 906961899,
      "collectionId": 1536069072,
      "trackId": 1536069073,
      "artistName": "Red Velvet",
      "collectionName":
      "START-UP (Original Television Soundtrack), Pt. 1 - Single",
      "trackName": "Future",
      "previewUrl":
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview114/v4/df/f7/d7/dff7d79e-be21-5ddc-95d8-ba892ac5ee28/mzaf_17332779181741734427.plus.aac.p.m4a",
      "artworkUrl60":
      "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/ec/82/f1/ec82f1a9-4917-8f1e-790c-e521f21efb8e/source/60x60bb.jpg",
    },
    {
      "artistId": 949319364,
      "collectionId": 1536068529,
      "trackId": 1536068530,
      "artistName": "Jung Seung Hwan",
      "collectionName":
      "START-UP (Original Television Soundtrack), Pt. 2 - Single",
      "trackName": "Day & Night",
      "previewUrl":
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview124/v4/aa/db/39/aadb39a6-5e8b-a325-269f-c6568e4cbd93/mzaf_1014252217466097855.plus.aac.p.m4a",
      "artworkUrl60":
      "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/5c/22/f2/5c22f2a2-82c3-a11b-629d-08950047b2ad/source/60x60bb.jpg",
    },
    {
      "artistId": 1071214298,
      "collectionId": 1538114733,
      "trackId": 1538114735,
      "artistName": "Gaho",
      "collectionName":
      "START-UP (Original Television Soundtrack), Pt. 5 - Single",
      "trackName": "Running",
      "previewUrl":
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview114/v4/8d/a4/76/8da476e5-bec8-47c9-61b3-7c212ea95146/mzaf_16088142087258647238.plus.aac.p.m4a",
      "artworkUrl60":
      "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5f/f5/de/5ff5de1d-ce9b-c5fc-36c1-4c7a0caef259/source/60x60bb.jpg",
    }
  ]
});