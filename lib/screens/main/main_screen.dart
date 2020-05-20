import 'package:flutter/material.dart';
import 'package:mim2/screens/search_in_api/search_api.dart';
import 'package:mim2/screens/books_lib/books_lib_screen.dart';
import 'package:mim2/screens/games_lib/games_lib_screen.dart';
import 'package:mim2/screens/movies_lib/movies_lib_screen.dart';
import 'package:mim2/widgets/send_to_database.dart';
import 'package:mim2/model/record_type.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List<Widget> _widgetOptions = <Widget>[
    GamesScreen(),
    MoviesScreen(),
    BooksLibScreen(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    super.initState();
  }

  void _handleTabIndex(){
    setState(() {
    });
  }

  String changeName(){
      if(_tabController.index==0){
        return "Filmy";
      }
      else if (_tabController.index==1 ){
        return "Gry";
      }
      else if( _tabController.index==2){
        return "Książki";
      }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(changeName()),
          backgroundColor: _indicatorColor(),
        ),
        floatingActionButton: _bottomButtons(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MoviesScreen(),
            GamesScreen(),
            BooksLibScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: _indicatorColor(),
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.local_movies),
            ),
            Tab(
              icon: Icon(Icons.videogame_asset),
            ),
            Tab(
              icon: Icon(Icons.book),
            )
          ],
        ),
      ),

    );
  }

  Color _indicatorColor(){
    if(_tabController.index==0){
      return Colors.blueAccent;
    }
    else if (_tabController.index==1 ){
      return Colors.redAccent;
    }
    else if( _tabController.index==2){
      return Colors.amberAccent;
    }
  }

  Widget _bottomButtons(){
    if(_tabController.index==0){
      return
        FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: (){Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchForMovieScreen(), ));},
          backgroundColor: Colors.blue,
          child: Icon(Icons.search, size: 30,color: Colors.white70),
        );
    }
    else if(_tabController.index==1){
      return
        FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: (){Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SendToDatabase(RecordType.GAMEADD), ));},
          backgroundColor: Colors.red,
          child: Icon(Icons.gamepad, size: 25,color: Colors.white70),
        );
    }
    else if(_tabController.index==2){
      return
        FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: (){Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SendToDatabase(RecordType.BOOKADD,), ));
          },
          backgroundColor: Colors.amber,
          child: Icon(Icons.library_books, size: 25,color: Colors.white70),
        );
    }
  }
}
