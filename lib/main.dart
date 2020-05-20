import 'package:flutter/material.dart';
import 'package:mim2/api/api_provider.dart';
import 'package:mim2/blocs/firebase_db_bloc.dart';
import 'package:mim2/blocs/log_reg_bloc.dart';
import 'package:mim2/blocs/omdb_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:mim2/model/omdb_repository.dart';
import 'package:mim2/screens/login_screen/log_reg_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: _blocs,
      dependencies: _dependencies,
      child: MaterialApp(
          title: 'Mim2',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.blue,
              accentColor: Colors.lightBlueAccent,
              brightness: Brightness.dark
          ),
          home: LogRegScreen()
      ),
    );
  }

  List<Bloc> get _blocs => [
    Bloc((_) => LogRegBloc()),
    Bloc((_) => DatabaseBloc()),
    Bloc((i) => OmdbBloc(i.get())),
  ];

  List<Dependency> get _dependencies =>[
    Dependency((_) => Dio()),
    Dependency((i) => OmdbMoviesProvider(i.get())),
    Dependency((i) => OmdbRepository(i.get())),
  ];

}



