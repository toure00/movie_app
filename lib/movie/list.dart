import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';

Dio dio = new Dio();


// 有状态控件
class MovieList extends StatefulWidget{
  MovieList({Key key,  this.mt ,this.query,this.pageKey}):super(key:key);
  // 电影类型
  final String mt;
  final String query;
  PageStorageKey<MovieList> pageKey;

  @override
  _MovieListState createState() {
    return new _MovieListState();
  }
}

// 有状态控件,必须结合一个状态管理类,来进行实现
class _MovieListState extends State<MovieList> with AutomaticKeepAliveClientMixin{
  int _start = 0;
  int _pagesize = 10;
  int _total = -1;
  var mlist = [];

  @override
  bool get wantKeepAlive => true;
  //下拉加载更多
  ScrollController _scrollController = ScrollController();

  // 控件被创建时,会执行initState
  @override
  void initState(){
    super.initState();
    //下拉加载更多
    _scrollController.addListener((){
      if (_scrollController.position.pixels == 
          _scrollController.position.maxScrollExtent)
          getMovieList();
    });
    getMovieList();
  }


  // 渲染 MovieList 控件的
  @override
  Widget build(BuildContext context) {
    // 循环渲染需要listview.builder
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("img/1.jpg"),
          fit: BoxFit.cover,
        )
      ),
      child: ListView.builder(
      itemCount: mlist.length,
      key: PageStorageKey(context),
      //下拉加载更多
      controller: _scrollController,
      itemBuilder: (BuildContext ctj, int i){
        var mitem = mlist[i];
        // var acter = mitem['casts'].length != 0 ? mitem['casts'][0]['name']:"";
        return GestureDetector(
          child: _cardItem(mitem),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MovieDetail(id: mitem['id'], title: mitem['title'],)
            ));
          },
        );
      }
    ),);
  }

  _cardItem (Map mitem){
    var acterList = [];
    if (mitem['casts'].length!=0){
      mitem['casts'].forEach((item){
          acterList.add(item["name"]);
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
                  image: NetworkImage(mitem['images']['small']),
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
                  Text("电影名称: ${mitem['title']}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("上映年份: ${mitem['year']}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("电影类型: ${mitem['genres'].join(",")}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("豆瓣评分: ${mitem['rating']['average']}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                  Text("主要演员: " + acterList.join(','),overflow: TextOverflow.ellipsis, maxLines: 1,style: TextStyle(fontSize: 12,color: Colors.black54),),
              ],),
            ),
            ),
          ],
        ),
      ),
    );
  }

  getMovieList() async {
    // int offset = (page-1)*pagesize;
    // var response = await dio.get('https://api.douban.com/v2/movie/${widget.mt}?start=$offset&count=$pagesize');
    // var response = await dio.get('http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}');
    if (mlist.length != _total){
    _start = mlist.length;
    var response;
    // var response = await dio.get('https://api.douban.com/v2/movie/${widget.mt}');
    if (widget.query == null){
    response = await dio.get('https://api.douban.com/v2/movie/${widget.mt}?start=$_start&count=$_pagesize');
    }
    response = await dio.get('https://api.douban.com/v2/movie/${widget.mt}?q=${widget.query}&start=$_start&count=$_pagesize');
    var result = response.data;
    _total = result['total'];
    print(result);
    // 只要为私有数据赋值,都需要把赋值的操作放到 setState 中, 否则 ,页面不会更新.
    setState(() {
        mlist.addAll(result['subjects']);
    });
    }
}
}
