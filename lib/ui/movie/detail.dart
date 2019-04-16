import 'package:flutter/material.dart';
import '../../bloc/movie_detail_bloc.dart';
import '../../model/movie_detail_model.dart';

class MovieDetail extends StatelessWidget {
  final id;
  final title;
  MovieDetail({@required this.id,this.title});

  dispose(){
    movieDetailBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    movieDetailBloc.fetchMovieDetail(this.id);
    return Scaffold(
      appBar: AppBar(title: Text(this.title), centerTitle: true,),
      body: StreamBuilder(
      stream: movieDetailBloc.movieDetail,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return _buildContent(context,snapshot);
        }else if(snapshot.hasError){
          return Text(snapshot.error.toString()); 
          }
        return Container( padding: EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator(),),);
      },
    )
    );
  }

  _buildContent(BuildContext context,snapshot){
    MovieDetailModel details = snapshot.data;

    return ListView(children: <Widget>[
        Card( 
          child: Row(children: <Widget>[
              Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(details.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0)
                  )
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 200,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Text("电影名称: " + details.title,style: TextStyle(fontSize: 12,color: Colors.black54), ),
                  Text("出品国家: " + details.attrs.country.join(","),style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("电影类型: " + details.attrs.movieType.join(","),style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("影片时长: " + details.attrs.movieDuration.join(","), maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("上映时间: " + details.attrs.year.join(","),style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("主要演员: " + details.attrs.cast.join(","), maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.black54),)
              ],)
                ),
              ),
        ],),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("电影简介:\n\n" + details.summary, style: TextStyle(fontSize: 12, color: Colors.black54),),
        ),
      ],
    );
  }
}