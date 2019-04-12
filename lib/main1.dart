import 'package:flutter/material.dart';
import './movie/list.dart';
import './widget/tab_bar_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "movies",
      home: DefaultTabController(
        length: 3,
        child: MyHome(),
      )
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 导航区
      appBar: AppBar(
        title: Text("🐳影视"),
        centerTitle: true,
        //左侧行为button
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){},)
        ],
        ),
        //  侧边栏区
        drawer: MyDrawer(),
        // 内容主体
        body: MyBody(),
        // 底部菜单区
        bottomNavigationBar: MyTabBar(),
      // body: ,
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
  }
}

class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      height: 50,
      child: TabBar(
        labelStyle: TextStyle(height: 0,fontSize: 10),
        indicatorColor: Colors.white,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.movie_creation),text: "即将上映",),
        Tab(icon: Icon(Icons.movie_filter),text: "正在热映",),
        Tab(icon: Icon(Icons.local_movies),text: "TOP250",),
      ],
    ),
    );
  }
}

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        MovieList(mt: "coming_soon",),
        MovieList(mt: "in_theaters",),
        MovieList(mt: "top250",),
      ],
    );
  }
}