import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mim2/blocs/firebase_db_bloc.dart';
import 'package:mim2/blocs/omdb_bloc.dart';
import 'package:mim2/model/lib.dart';
import 'package:mim2/model/movie_details.dart';
import 'package:mim2/screens/movies_lib/movie_instance.dart';
import 'package:mim2/screens/movie_details_screen.dart';

class MoviesLibContent extends StatefulWidget {
  @override
  _MoviesLibContentState createState() => _MoviesLibContentState();
}

class _MoviesLibContentState extends State<MoviesLibContent> {

  List<Library> listofMovies = [];
  DatabaseBloc _databaseBloc;
  OmdbBloc _omdbBloc;

  @override
  void initState() {
    _omdbBloc = BlocProvider.getBloc();
    _databaseBloc = BlocProvider.getBloc();
    _databaseBloc.deletedMovieIdObservable.listen(onDeletedMovie);
    _databaseBloc.onMovieAdded.listen(onMovieAdded);
    _omdbBloc.movieStream.listen(onData);
    super.initState();
  }

  void onData(MovieT movieDetails){
    final movieContext = PassContext(movieT: movieDetails,);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => movieContext));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: ListView.builder(
              itemCount: listofMovies.length,
              itemBuilder: (_, position) {
                return Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: ObjectKey(listofMovies[position]),
                    onDismissed: (direction){
                      _databaseBloc.removeItemFromFireBaseDatabase(listofMovies[position]);
                      setState(() {
                        listofMovies.removeAt(position);
                      });
                    },
                    child: MovieInstance(listofMovies[position]));},

            )
        )
    );
  }

  void onMovieAdded(Library library){
    setState(() {
      listofMovies.add(library);
    });
  }

  void onDeletedMovie(Library library){
    setState(() {
      listofMovies.remove(library);
    });
  }

  void _scrollListener(){}
}
