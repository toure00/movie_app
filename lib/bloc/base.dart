import 'package:rxdart/rxdart.dart';
import '../resource/repository.dart';

abstract class BaseBloc<T>{

  final repository = Repository();
  final fetcher = PublishSubject<T>();

  dispose(){
    print("销毁了....");
    fetcher.close();
  }
}