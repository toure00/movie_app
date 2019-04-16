import 'package:flutter/material.dart';
import './detail.dart';
import '../../bloc/movie_list_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/move_list_model.dart';

class MovieList extends StatelessWidget{
  MovieList({Key key,  this.mt ,this.query,}):super(key:key);
  // 电影类型
  String mt;
  String query;

  bool isLoading = false;
  // bool isBottom= false;
  int isBottom= 1;

  MovieListBloc movieListBloc;

  //下拉加载更多
  ScrollController _scrollController = ScrollController();

  //监听scrollcontroller滚动行为方法
  _getController(){
    _scrollController.addListener((){
        if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent)
        _getMoreData();
    });
  }

  Future _getMoreData() async {
    if(!isLoading){
      isLoading = true;
      isBottom = await movieListBloc.loadMoreList(this.mt,this.query);
      isLoading = false;
    }
  }

  Widget _buildLoading (){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(child: CircularProgressIndicator()));
  }

  //   Widget _buildLoading() {
  //   return new Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: new Center(
  //       child: new Opacity(
  //         opacity: isLoading ? 0.0 : 1.0,
  //         child: new CircularProgressIndicator(),
  //       ),
  //     ),
  //   );
  // }



  // 实例化一个MovieListBloc 如果多个Widget公用数据 , 可以在movie_list_bloc文件中定义 , 全局单例模式;
  // MovieListBloc movieListBloc = MovieListBloc();



  @override
  Widget build(BuildContext context) {
    _getController();
    switch (this.mt) {
      case "coming_soon":
      movieListBloc = comingSoon;
      break;
      case "in_theaters":
      movieListBloc = inTheaters;
      break;
      case "top250":
      movieListBloc = top250;
      break;
      case "search":
      movieListBloc = MovieListBloc();
      break;
    }
    movieListBloc.fetchMovieList(this.mt,this.query);
    return StreamBuilder(
      stream: movieListBloc.movieList,
      // builder: (context,snapshot)=> !snapshot.hasData || snapshot.data.isEmpty ? 
      // _buildLoading() : buildContent(snapshot, context),
      builder: (context,snapshot){
        if (snapshot.hasData) {
          return buildContent(snapshot, context);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return _buildLoading();
      },
    );
  }

  Widget buildContent(snapshot,context){
    MovieListModel mlist = snapshot.data;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("img/1.jpg"),
          fit: BoxFit.cover,
        )
      ),
      child: ListView.builder(
        key: PageStorageKey(this.mt),
        itemCount: mlist.subjects.length +1,
        //滚动控制器,下拉加载更多
        controller: _scrollController,
        itemBuilder: (context, i){
          if (mlist.subjects.length== i){
            // if (isBottom){
            if (isBottom==0){
              Fluttertoast.showToast(msg: '已经到底了',backgroundColor: Colors.purple,textColor: Colors.white);
              return null;
            }
            return _buildLoading();
          }
          else{
            Subjects mitem = mlist.subjects[i];
            return GestureDetector(
              child: _cardItem(mitem),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    MovieDetail(id: mitem.id, title: mitem.title,)
                ));
              },
            );
          }
        }
    ),);
  }

  _cardItem (Subjects mitem){
    var acterList = [];
    if (mitem.casts.length!=0){
      mitem.casts.forEach((item){
          acterList.add(item.name);
      });
    }
    return Card(
      // margin: EdgeInsets.all(5),
      child: Container(
        height: 200,
        // decoration: BoxDecoration(color: Colors.white30, border: Border(top: BorderSide(color: Colors.black12))),
        child: Row(
          children: <Widget>[
            // 给图片加圆角
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(mitem.images.small),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                )
              ),
            ),
            // Expanded 可以解决溢出问题
            Expanded(child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("电影名称: ${mitem.title}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                    Text("上映年份: ${mitem.year}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                    Text("电影类型: ${mitem.genres.join(",")}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                    Text("豆瓣评分: ${mitem.rating.average}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                    Text("主要演员: " + acterList.join(','),overflow: TextOverflow.ellipsis, maxLines: 1,
                      style: TextStyle(fontSize: 12,color: Colors.black54),),
                ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
