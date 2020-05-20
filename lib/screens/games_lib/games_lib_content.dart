import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mim2/screens/games_lib/game_instance.dart';
import 'package:mim2/blocs/firebase_db_bloc.dart';
import 'package:mim2/model/lib.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class GamesLibContent extends StatefulWidget {
  @override
  _GamesLibContentState createState() => _GamesLibContentState();
}

class _GamesLibContentState extends State<GamesLibContent> {

  List<Library> listofGames = [];
  DatabaseBloc _databaseBloc;
  StreamSubscription streamSubscriptionDelete;
  StreamSubscription streamSubscriptionAdd;

  @override
  void initState() {
    _databaseBloc = BlocProvider.getBloc();
    streamSubscriptionDelete = _databaseBloc.deletedGameIdObservable.listen(onDeleteItem);
    streamSubscriptionAdd = _databaseBloc.onGameCAdded.listen(onGameAdded);
    super.initState();
  }

  @override
  void dispose() {
    streamSubscriptionAdd.cancel();
    streamSubscriptionDelete.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: ListView.builder(
              itemCount: listofGames.length,
              itemBuilder: (_, position) { return Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: ObjectKey(listofGames[position]),
                  onDismissed: (direction){
                    _databaseBloc.removeItemFromFireBaseDatabase(listofGames[position]);
                    setState(() {
                      listofGames.removeAt(position);
                    });
                  },
                  child: GameInstance(listofGames[position]));},
            )
        )
    );
  }

  void onGameAdded(Library library){
    setState(() {
      listofGames.add(library);
    });
  }

  void onDeleteItem(Library library){
    setState(() {
      listofGames.remove(library);
    });
  }

}
