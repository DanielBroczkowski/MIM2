import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mim2/blocs/firebase_db_bloc.dart';
import 'package:mim2/model/lib.dart';
import 'package:mim2/screens/books_lib/book_instance.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class BooksLibContent extends StatefulWidget {
  @override
  _BooksLibContentState createState() => _BooksLibContentState();
}

class _BooksLibContentState extends State<BooksLibContent> {

  List<Library> listofBooks = [];
  DatabaseBloc _databaseBloc;
  StreamSubscription subscriptiononBookAdded;
  StreamSubscription subscriptiononBookDeleted;

  @override
  void initState() {
    _databaseBloc = BlocProvider.getBloc();
    subscriptiononBookDeleted = _databaseBloc.deletedBookIdObservable.listen(onDeleteItem);
    subscriptiononBookAdded = _databaseBloc.onBookAdded.listen(onBookAdded);
    super.initState();
  }
  @override
  void dispose() {
    subscriptiononBookDeleted.cancel();
    subscriptiononBookAdded.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: ListView.builder(
              itemCount: listofBooks.length,
              itemBuilder: (_, position) { return Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: ObjectKey(listofBooks[position]),
                  onDismissed: (direction){
                    _databaseBloc.removeItemFromFireBaseDatabase(listofBooks[position]);
                    setState(() {
                      listofBooks.removeAt(position);
                    });
                  },
                  child: BookInstance(listofBooks[position]));},
            )
        )
    );
  }

  void onBookAdded(Library library){
    setState(() {
      listofBooks.add(library);
    });
  }

  void onDeleteItem(Library library){
    setState(() {
      listofBooks.removeWhere((item) => item.getItemId() == library.getItemId());
    });
  }
}
