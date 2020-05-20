import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mim2/blocs/omdb_bloc.dart';
import 'package:mim2/model/search_movies.dart';
import 'package:mim2/screens/movies_lib/movie_instance.dart';

class SearchForMovieScreen extends StatefulWidget {
  @override
  _SearchForMovieScreenState createState() => _SearchForMovieScreenState();
}

class _SearchForMovieScreenState extends State<SearchForMovieScreen> {

  OmdbBloc _omdbBloc;
  StreamSubscription searchSubscription;
  SearchMovies listOfMovies;
  TextEditingController searchController;

  @override
  void initState() {
    _omdbBloc = BlocProvider.getBloc();
    listOfMovies = SearchMovies(results: []);
    searchSubscription = _omdbBloc.searchStream.listen(onSearchResult);
    super.initState();
  }

  @override
  void dispose() {
    searchSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.blueAccent),
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Form(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: searchController,
                              onChanged: (text)  => {_omdbBloc.fetchResults(text)},
                              decoration: InputDecoration(
                                hintText: 'Szukaj filmu...',
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: listOfMovies.results?.length ?? 0  ,
                    itemBuilder: (_, position) => MovieInstance.Search(is_Search: true, movieS: listOfMovies.results[position], ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSearchResult(SearchMovies list){
    setState(() {
      listOfMovies= list;
    });
  }
}