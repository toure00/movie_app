import 'dart:async';
import './bloc_base.dart';
import 'package:dio/dio.dart';
Dio dio = new Dio();

class GetMovieListBloc implements BlocBase {
  List _movieList;

  StreamController<List> _movieListPipe = StreamController<List>();
  Stream<List> get outCounter => _movieListPipe.stream;

  GetMovieListBloc() {
    _movieList = [];
    //_counterPipe 用于StreamBuilder，已经自动加了listen
  }

  getMovieList() {

  }

  void dispose() {
    print('bloc disposed!');
    _movieListPipe.close();
  }
}
