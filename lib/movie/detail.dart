import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

class MovieDetail extends StatefulWidget {
  MovieDetail({Key key, this.id , this.title}):super(key:key);
  final String id;
  final String title;
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var details;

  @override
  void initState(){
    super.initState();
    getMovieDetail();
  }

  @override
  Widget build(BuildContext context) {
      var summary ="";
      var imgurl="";
      var title = "";
      var countries = "";
      var genres = "";
      var acter = "";
      var year = "";
      var time = "";
      if (details != null){
        summary = details['summary'] == null ? "" : details['summary'];
        imgurl = details['image'] == null ? "" : details['image'];
        title = details['title'] == null ? "" : details['title'];
        countries = details['attrs']['country'] == null ? "" : details['attrs']['country'].join(",");
        genres = details['attrs']['movie_type'] == null ? "" : details['attrs']['movie_type'].join(',');
        year = details['attrs']['year'] == null ? "" : details['attrs']['year'].join(",");
        acter = details['attrs']['cast'] == null ? "" : details['attrs']['cast'].join(",");
        time = details['attrs']['movie_duration'] == null ? "" : details['attrs']['movie_duration'].join(',');
      };
        return Scaffold(
          appBar: AppBar(title: Text(widget.title), centerTitle: true,),
          body: ListView(children: <Widget>[
            Card( 
              child: Row(children: <Widget>[
                  Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgurl),
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
                      Text("电影名称: " + title,style: TextStyle(fontSize: 12,color: Colors.black54), ),
                      Text("出品国家: " + countries,style: TextStyle(fontSize: 12,color: Colors.black54),),
                      Text("电影类型: " + genres,style: TextStyle(fontSize: 12,color: Colors.black54),),
                      Text("影片时长: " + time, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.black54),),
                      Text("上映时间: " + year,style: TextStyle(fontSize: 12,color: Colors.black54),),
                      Text("主要演员: " + acter, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.black54),)
                  ],)
                    ),
                  ),
            ],),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("电影简介:\n\n"+summary, style: TextStyle(fontSize: 12, color: Colors.black54),),
            ),
          ],)
        );
  }

  getMovieDetail() async {
    // var response = await dio.get("http://www.liulongbin.top:3005/api/v2/movie/subject/${widget.id}");
    var response = await dio.get("https://api.douban.com/v2/movie/${widget.id}");
    var result = response.data;
    // print(result);
    setState(() {
      details = result;
      print(details);
    });
  }
}