
import 'dart:convert';

import 'package:assessment_bcg_telkomsel/model/api_response.dart';
import 'package:dio/dio.dart';

abstract class ImplTrackRepository {
  Future<ApiResponse> searchBy(String query);
}

class TrackRepository implements ImplTrackRepository {
  @override
  Future<ApiResponse> searchBy(String query) async {
    final result = await Dio()
        .get('https://itunes.apple.com/search?country=ID&term=$query');
    return ApiResponse.fromJson(jsonDecode(result.data));
  }
}