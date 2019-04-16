import 'dart:async';
import './movie_api_provider.dart';
import '../model/move_list_model.dart';
import '../model/movie_detail_model.dart';
class Repository {
  MovieApiProvider movieApiProvider = MovieApiProvider();

  Future<MovieListModel> fetchMovieList(Map mp) =>  movieApiProvider.fetchMovieList(mp);
  Future<MovieDetailModel> fetchMovieDetail(String id) => movieApiProvider.fetchMovieDetail(id);
}