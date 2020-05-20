import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mim2/blocs/firebase_db_bloc.dart';
import 'package:mim2/blocs/omdb_bloc.dart';
import 'package:mim2/model/lib.dart';
import 'package:mim2/model/movie.dart';
import 'package:mim2/model/movie_api.dart';

class MovieInstance extends StatefulWidget {

  bool is_Search = false;
  Library movie;
  MovieInstance(this.movie);
  MovieS movieS;

  MovieInstance.Search({this.is_Search, this.movieS}){
    movie = Library(movie: Movie(year: movieS.year, title: movieS.title, id: movieS.id));
  }

  @override
  _MovieInstanceState createState() => _MovieInstanceState();
}

class _MovieInstanceState extends State<MovieInstance> {

  Library movie;
  OmdbBloc _omdbBloc;
  DatabaseBloc _databaseBloc;

  @override
  void initState() {
    _databaseBloc = BlocProvider.getBloc();
    _omdbBloc = BlocProvider.getBloc();
    movie = widget.movie;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff2e2e2e).withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.blueAccent),
          boxShadow: [
            BoxShadow(
              //color: Colors.blueAccent[100],
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: (){
            _omdbBloc.getTitle(movie.getItemId());
          },
          child: ListTile(
            leading: Icon(Icons.local_movies , size: 50,),
            title: Text("Tytuł: ${movie.movie.title}", style: TextStyle(fontSize: 20,),),
            subtitle: Text("Rok produkji: ${movie.movie.year}"),
            trailing: InkWell(
                onTap: widget.is_Search ?
                    (){
                  _databaseBloc.addItemToFireBaseDatabase(movie);
                }:(){
                  DeleteMovie();
                },
                child: widget.is_Search ? Icon(Icons.add) : Icon(Icons.cancel)
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }

  String ifMovieWatched(){
    if(movie.movie.watched == true){
      return "tak";
    }
    else{
      return "nie";
    }
  }

  void DeleteMovie(){
    _databaseBloc.removeItemFromFireBaseDatabase(movie);
  }
}

