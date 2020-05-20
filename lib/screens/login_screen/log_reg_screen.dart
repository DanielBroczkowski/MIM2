import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mim2/blocs/log_reg_bloc.dart';
import 'package:mim2/blocs/firebase_db_bloc.dart';
import 'package:mim2/screens/login_screen/login_screen_content.dart';
import 'package:mim2/screens/login_screen/register_screen_content.dart';
import 'package:mim2/screens/main/main_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';


class LogRegScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LogRegScreenState();
  }

}

class LogRegScreenState extends State<LogRegScreen> with SingleTickerProviderStateMixin{
  ProgressDialog progressDialog;
  LogRegBloc _logRegBloc;
  StreamSubscription _registerSubscription;
  StreamSubscription _toastMessage;
  StreamSubscription _currentUser;
  DatabaseBloc _databaseBloc;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    _logRegBloc= BlocProvider.getBloc();
    _registerSubscription = _logRegBloc.loadingLoginRegister.listen(loadingScreen);
    _toastMessage = _logRegBloc.messageObservable.listen(showtoast);
    _currentUser = _logRegBloc.currentUser.listen(changeViewIfLoggedIn);
  }

  void check(){
    _databaseBloc.getUserUid();
    if (_databaseBloc.userUid!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainScreen(),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _registerSubscription.cancel();
    _toastMessage.cancel();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(
        message: "Ładowanie..."
    );


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: SizedBox(
                  height: 70,
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Image(
                      image: AssetImage('images/kwak.png'),
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[


                      Expanded( flex:0 ,child: SizedBox(height: 40,)),
                      Expanded(
                        flex: 1,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: <Widget>[
                            LoginScreenContent(),
                            RegisterScreenContent(),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TabBar(
                                controller: _tabController,
                                tabs: <Widget>[
                                  Tab(
                                    text: "Zaloguj",
                                  ),
                                  Tab(
                                    text: "Zarejestruj",
                                  ),
                                ],
                              ),
                              flex: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 80,
                                height: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeViewIfLoggedIn(FirebaseUser user){
    if (user.uid!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainScreen(),
      ));

      if(_databaseBloc != null){
        _databaseBloc.userUid = user.uid;
      }
    }
  }

  void loadingScreen(bool b){
    if(b) progressDialog.show();
    else progressDialog.hide();
  }

  void showtoast(String message){
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}