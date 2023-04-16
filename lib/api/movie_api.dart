import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study_toon/model/movie_detail_model.dart';
import 'package:study_toon/model/movie_preview_model.dart';

import 'consts.dart';

class MovieApi {
  static const String popularUrl = "${Consts.baseUrl}/popular";
  static const String nowPlayingUrl = "${Consts.baseUrl}/now-playing";
  static const String comingSoonUrl = "${Consts.baseUrl}/coming-soon";
  static String detailUrl(int id) => "${Consts.baseUrl}/movie?id=$id";

  static Future<List<MoviePreviewModel>> getPopularMovies() async {
    List<MoviePreviewModel> previewList = [];
    final response = await http.get(Uri.parse(popularUrl));
    if(response.statusCode == Consts.successCode) {
      final previews = jsonDecode(response.body)['results'];
      for(var preview in previews) {
        previewList.add(MoviePreviewModel.fromJson(preview));
      }
      return previewList;
    }
    throw Error();
  }

  static Future<List<MoviePreviewModel>> getNowPlayingMovies() async {
    List<MoviePreviewModel> playingList = [];
    final response = await http.get(Uri.parse(nowPlayingUrl));
    if(response.statusCode == Consts.successCode) {
      final previews = jsonDecode(response.body)['results'];
      for(var preview in previews) {
        playingList.add(MoviePreviewModel.fromJson(preview));
      }
      return playingList;
    }
    throw Error();
  }

  static Future<List<MoviePreviewModel>> getComingSoonMovies() async {
    List<MoviePreviewModel> playingList = [];
    final response = await http.get(Uri.parse(comingSoonUrl));
    if(response.statusCode == Consts.successCode) {
      final previews = jsonDecode(response.body)['results'];
      for(var preview in previews) {
        playingList.add(MoviePreviewModel.fromJson(preview));
      }
      return playingList;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getDetailMovie(int id) async {
    final response = await http.get(Uri.parse(detailUrl(id)));
    if(response.statusCode == Consts.successCode) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}