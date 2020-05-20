import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mim2/blocs/omdb_bloc.dart';
import 'package:mim2/model/lib.dart';
import 'package:mim2/model/movie_details.dart';

class PassContext extends StatefulWidget {

  String title;
  String imageString = "https://i.wpimg.pl/415x600/i.wp.pl/a/f/film/008/99/45/0094599.jpg";
  MovieT movieT;
  PassContext({this.movieT});
  @override
  _PassContextState createState() => _PassContextState();
}

class _PassContextState extends State<PassContext> {

  OmdbBloc _omdbBloc;
  StreamSubscription result;
  Image image;
  MovieT movie;
  List<String> actors =["trs"];

  @override
  void initState() {
    _omdbBloc = BlocProvider.getBloc();
    movie = widget.movieT;
    image = Image.network(movie.poster);
    result = _omdbBloc.movieStream.listen(fetchData);
    if(movie.poster=="N/A"){
      image=Image.network("https://sciences.ucf.edu/psychology/wp-content/uploads/sites/63/2019/09/No-Image-Available.png");
    }
    super.initState();
  }

  void fetchData(MovieT movieResult){
    movie = movieResult;
  }

  @override
  void dispose() {
    result.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.grey[300] , fontSize: 15),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: image),
                    Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                    SizedBox(width: 20,),
                                    Text("Typ:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text("${movie.type}", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                                ],
                              ),

                              Divider(height: 20, thickness: 2, color: Colors.white70),

                              Row(
                                children: <Widget>[
                                    SizedBox(width: 20,),
                                    Flexible(child: Text("Gatunki:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Flexible(
                                    child: Text("${movie.genre}", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                                  )
                                ],
                              ),

                              Divider(height: 20, thickness: 2, color: Colors.white70),

                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text("Czas trwania:" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text(movie.runtime, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                                ],
                              ),

                              Divider(height: 20, thickness: 2, color: Colors.white70),

                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text("Rok produkcji:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text(movie.released, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                                ],
                              ),

                              Divider(height: 20, thickness: 2, color: Colors.white70),

                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text("Ocena:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 20,),
                                  Text(movie.imdbRate, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                                ],
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text("Fabuła:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                ),

                Padding(
                  padding: EdgeInsets.only(top:5, bottom: 15),
                  child: Text(movie.plot, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                ),

                Divider(height: 20, thickness: 2, color: Colors.white70),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text("Reżyserowie" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300), ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(movie.director , style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                ),

                Divider(height: 20, thickness: 2, color: Colors.white70),

                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: Text("Aktorzy" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300), ),),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: movie.actorsList().length,
                    itemBuilder: (_, position) {return Row(
                      children: <Widget>[
                        Text(movie.actorsList()[position], style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                      ],
                    );})
              ],
            ),
          ),
        ),
      ),
    );
  }

}