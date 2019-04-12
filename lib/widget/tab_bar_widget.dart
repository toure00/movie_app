import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {

  static const BOTTOM_TAB = 1;
  static const TOP_TAB  =2;
  final int type;
  final List<Widget> tabItems;
  final List<Widget> tabViews;
  final List<Widget> actions;
  final Color backgroundColor;
  final Color indicatorColor;
  final Widget title;
  final Widget drawer;
  final Widget floatingActionButton;
  final TarWidgetControl tarWidgetControl;
  final ValueChanged<int> onPageChanged;

  MyTabBar({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.actions,
    this.drawer,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.onPageChanged,
  }):super(key:key);

  @override
  _MyTabBarState createState() => _MyTabBarState(
    type,
    tabViews,
    actions,
    indicatorColor,
    title,
    drawer,
    floatingActionButton,
    tarWidgetControl,
    onPageChanged,
  );
}

class _MyTabBarState extends State<MyTabBar> with SingleTickerProviderStateMixin{
  final int _type;
  final List<Widget> _tabViews;
  final List<Widget> _actions;
  final Color _indicatorColor;
  final Widget _title;
  final Widget _drawer;
  final Widget _floatingActionButton;
  final TarWidgetControl _tarWidgetControl;
  final ValueChanged<int> _onPageChanged;
  final PageController _pageController = PageController();
  TabController _tabController;

  _MyTabBarState(
      this._type,
      this._tabViews,
      this._actions,
      this._indicatorColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._tarWidgetControl,
      this._onPageChanged,
  ):super();

  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this,length: widget.tabItems.length,);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext cootext) {
    final width  = MediaQuery.of(context).size.width;
    if (_type == MyTabBar.TOP_TAB){
      return Scaffold(
        floatingActionButton: _floatingActionButton,
        persistentFooterButtons: _tarWidgetControl == null ? [] : _tarWidgetControl.footerButton,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: _title,
          bottom: TabBar(
            labelStyle: TextStyle(height: 0,fontSize: 10),
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: _indicatorColor,
            onTap: (index){
              _onPageChanged?.call(index);
              _pageController.jumpTo(width*index);
            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: _tabViews,
          onPageChanged: (index){
            _onPageChanged?.call(index);
            _tabController.animateTo(index);
          },
        ),
      );
    }

    return Scaffold(
      drawer: _drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: _title,
        actions: _actions,
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: _tabViews,
        onPageChanged: (index){
          // _onPageChanged?.call(index);
          // 与TabBar关联, 使滑动切换时,TabBar一起切换
          _tabController.animateTo(index);
        },
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 50,
          child: TabBar(
          labelStyle: TextStyle(height: 0,fontSize: 10),
          controller: _tabController,
          tabs: widget.tabItems,
          indicatorColor: _indicatorColor,
          onTap: (index){
            // _onPageChanged?.call(index);
            // 与PageView关联, 如果没有此行代码, 切换TabBar时, PageView将不会切换
            _pageController.jumpTo(width*index);
          },
        ),
        ),
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}