import 'package:flutter/material.dart';
import './list.dart';

class MySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Scaffold(
                  appBar: AppBar(
                    title:Text("搜索"),
                    centerTitle: true,
                    ),
                    body: SearchConter(),
                    floatingActionButton:FloatingActionButton(
                      tooltip: "back",
                      onPressed: (){ Navigator.pop(context);},
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    // actions:[
                    //     IconButton(
                    //     icon: Icon(Icons.search),
                    //     onPressed: (){
                    //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx){
                    //         return Scaffold(
                    //           appBar: AppBar(title: Text("搜索: "+ _controller.text),),
                    //           body:  MovieList(mt: "search",query: _controller.text,),
                    //         );
                    //       }));
                    //     },
                    //   ),
                    // ],
                );
              }));

          },);
  }
}

class SearchConter extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,-0.7),
      constraints: BoxConstraints(minWidth: double.infinity,minHeight: double.infinity),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://api.neweb.top/bing.php"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Container(
        width: 300,
        height: 20,
        child: Theme(
        data: new ThemeData(primaryColor: Colors.lightBlue, hintColor: Colors.blue),
        child: TextField(
          controller: _controller,
          // textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87,fontSize: 18),
          decoration: new InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            prefixIcon: Icon(Icons.search,color: Colors.blue,),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10),
          ),
          onSubmitted: (text){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx){
                return Scaffold(
                  appBar: AppBar(title: Text("搜索: "+ text),centerTitle: true,),
                  body:  MovieList(mt: "search",query:text,),
                );
              }));
              _controller.text="";
          },
        ),
      ),
      ),
    );
  }
}
