import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:mim2/firebase/auth_manager.dart';
import 'package:mim2/firebase/database_manager.dart';
import 'package:mim2/model/lib.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseBloc extends BlocBase {

  String userUid = "";

  final dataBaseManager = FBDataBaseManager();
  final auth = auth_manager();

  BehaviorSubject<bool> _changesInDatabaseItem = BehaviorSubject();
  Stream<bool> get changesInDatabaseObservable => _changesInDatabaseItem.stream;

  Stream<Library> get onMovieChanged => dataBaseManager.catchMovieUpdate(getUserUid());
  Stream<Library> get onMovieAdded => dataBaseManager.onMovieAdded(getUserUid());

  BehaviorSubject<Library> _deletedMovie = BehaviorSubject();
  Stream<Library> get deletedMovieIdObservable => _deletedMovie.stream;

  BehaviorSubject<Library> _deletedGame = BehaviorSubject();
  Stream<Library> get deletedGameIdObservable => _deletedGame.stream;

  BehaviorSubject<Library> _deletedBook = BehaviorSubject();
  Stream<Library> get deletedBookIdObservable => _deletedBook.stream;

  Stream<Library> get onGameChanged => dataBaseManager.catchMovieUpdate(getUserUid());
  Stream<Library> get onGameCAdded => dataBaseManager.onGameAdded(getUserUid());

  Stream<Library> get onBookChanged => dataBaseManager.catchMovieUpdate(getUserUid());
  Stream<Library> get onBookAdded => dataBaseManager.onBookAdded(getUserUid());

  String getUserUid(){
    auth.getUser().then((onValue) {userUid= onValue.uid;});
    return userUid;
  }

  Future addItemToFireBaseDatabase(Library library) async {
    auth.getUser().then((onValue) {userUid= onValue.uid;});
    dataBaseManager.saveDataToDatabase(userUid, library);
    _changesInDatabaseItem.add(true);
    _changesInDatabaseItem.add(false);
  }

  Future removeItemFromFireBaseDatabase(Library library) async {
    auth.getUser().then((onValue) {userUid= onValue.uid;});
    if(library.game!=null){
      _deletedGame.add(library);
    }
    else if(library.movie!=null){
      _deletedMovie.add(library);
    }
    else if(library.book!=null){
      _deletedBook.add(library);
    }
    dataBaseManager.removeItem(userUid, library);
    _changesInDatabaseItem.add(true);
    _changesInDatabaseItem.add(false);
  }
}