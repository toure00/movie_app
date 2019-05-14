import 'dart:async';
import 'package:dio/dio.dart';
import '../model/move_list_model.dart';
import '../model/movie_detail_model.dart';

class MovieApiProvider {
  Dio dio = Dio();
  var apikey = "apikey=0df993c66c0c636e29ecbb5344252a4a";

  Future<MovieListModel> fetchMovieList(Map mp) async {
    var response;
    if (mp["query"]==null){
      response = await dio.get('https://api.douban.com/v2/movie/${mp["mt"]}?start=${mp["start"]}&count=${mp["pagesize"]}&$apikey');
    }
    print('https://api.douban.com/v2/movie/${mp["mt"]}?start=${mp["start"]}&count=${mp["pagesize"]}&q=${mp["query"]}&$apikey');
    response = await dio.get('https://api.douban.com/v2/movie/${mp["mt"]}?start=${mp["start"]}&count=${mp["pagesize"]}&q=${mp["query"]}&$apikey');
    var result = response.data;
    MovieListModel md = MovieListModel.fromJson(result);
    return md;
  }

  Future<MovieDetailModel> fetchMovieDetail(String id) async{
    var response = await dio.get("https://api.douban.com/v2/movie/$id?$apikey");
    var result = response.data;
    MovieDetailModel md = MovieDetailModel.fromJson(result);
    return md;
  }
}