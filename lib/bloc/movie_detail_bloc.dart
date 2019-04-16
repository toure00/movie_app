import './base.dart';
import 'package:rxdart/rxdart.dart';
import '../model/movie_detail_model.dart';

class MovieDetailBloc extends BaseBloc<MovieDetailModel> {
  Observable<MovieDetailModel> get movieDetail=> fetcher.stream;
    fetchMovieDetail(String id) async{
      var data = await repository.fetchMovieDetail(id);
      fetcher.sink.add(data);
    }
  }

// 全局单例模式
final movieDetailBloc = MovieDetailBloc();