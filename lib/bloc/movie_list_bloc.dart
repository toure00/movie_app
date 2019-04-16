import './base.dart';
import 'package:rxdart/rxdart.dart';
import '../model/move_list_model.dart';
class MovieListBloc extends BaseBloc<MovieListModel> {
  int _start = 0;
  int _pagesize = 10;
  int _total = 1;
  MovieListModel _mlist = MovieListModel();
  bool _firstLoad = true;
  Observable<MovieListModel> get movieList => fetcher.stream;
    fetchMovieList(String type,String query) async{
      if (_firstLoad){
        loadMoreList(type, query);
        _firstLoad = false;
      }else{ 
        Future f = new Future(() => null);
        f.then((_)=>fetcher.sink.add(_mlist));
      }
    }
    loadMoreList(String type,String query) async{
      if (_firstLoad){
        Map mp = {"mt":type,"start":_start,"pagesize":_pagesize,"query":query};
        var data = await repository.fetchMovieList(mp);
        _mlist =data;
        fetcher.add(_mlist);
      }
      else{
        if (_total == _mlist.subjects.length){
          fetchMovieList(type, query);
          return 0;
        }
        else{
        _start =  _mlist.subjects.length;
        Map mp = {"mt":type,"start":_start,"pagesize":_pagesize,"query":query};
        var data = await repository.fetchMovieList(mp);
        _total = data.total;
        _mlist.subjects.addAll(data.subjects);
        fetcher.sink.add(_mlist);
        }
      }
    }

  @override
  dispose() {
    print("销毁中");
    fetcher.close();
  }
}


final comingSoon = MovieListBloc();
final inTheaters= MovieListBloc();
final top250= MovieListBloc();