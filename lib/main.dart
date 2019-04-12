
import 'package:flutter/material.dart';
import './movie/list.dart';
import './movie/search.dart';
// import './widget/tab_bar_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin{
  final List  tab = [
    {"title":"即将上映","icon":Icon(Icons.movie_creation)},
    {"title":"正在热映","icon":Icon(Icons.movie_filter)},
    {"title":"TOP250","icon":Icon(Icons.local_movies)},
  ];

  TabController _controller ;

  @override
  initState(){
    super.initState();
    _controller = TabController(vsync: this,length: 3);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  _renderTab(){
    List<Widget> list = List(); for (int i = 0; i < tab.length; i++){
      list.add(
        Tab(text: tab[i]['title'],icon: tab[i]['icon'],)
      );
    }
    return list;
  }

  _renderPage(){
    return[
        MovieList(mt: "in_theaters",),
        MovieList(mt: "coming_soon",),
        MovieList(mt: "top250",),
    ];
  }

  Drawer _drawer = Drawer(
    child: ListView(
        // 消除ListView的边距
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("291774777@qq.com"),
            accountName: Text("jack"),
            currentAccountPicture:Image.network("https://avatars3.githubusercontent.com/u/33457469?s=400&v=4"),
            // 美化当前部件
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("https://api.neweb.top/bing.php"),
              fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(title: Text("用户反馈"),trailing: Icon(Icons.feedback),),
          ListTile(title: Text("系统设置"),trailing: Icon(Icons.settings),),
          ListTile(title: Text("我要发布"),trailing: Icon(Icons.send),),
          // 分割线
          Divider(),
          ListTile(title: Text("注销"),trailing: Icon(Icons.exit_to_app),),
        ],
      )
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("豆瓣电影"),
        actions: [MySearch()],
      ),
      drawer: _drawer,

      body: TabBarView(
        controller: _controller,
        children: _renderPage(),
      ),

      bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: TabBar(
            labelStyle: TextStyle(height: 0,fontSize: 10),
            controller: _controller,
            tabs: _renderTab(),
            indicatorColor: Colors.white,
          ),
        ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MyTabBar(
  //     type: 1,
  //     backgroundColor: Colors.black45,
  //     indicatorColor: Colors.white,
  //     tabItems: _renderTab(),
  //     tabViews: _renderPage(),
  //     title: Text("豆瓣电影"),
  //     actions: [ MySearch(),],
  //     drawer: _drawer,
  //   );
  // }
}
