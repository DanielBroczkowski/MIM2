import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mim2/blocs/log_reg_bloc.dart';

typedef void OnClick();

class LoginScreenContent extends StatefulWidget {
  final OnClick onPress;
  LoginScreenContent({this.onPress});

  @override
  _LoginScreenContentState createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  LogRegBloc _logRegBloc;

  @override
  void initState() {
    _logRegBloc= BlocProvider.getBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              onChanged: (text) {email=text;},
              style: TextStyle(fontSize: 17 ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: "Email:",
              ),
            ),

            SizedBox(height: 20,),
            TextFormField(
              obscureText: true,
              style: TextStyle(fontSize: 17 ),
              onChanged: (text) {password=text;},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: "Hasło:",
              ),
            ),
            SizedBox(height: 60,),
            InkWell(
              onTap: () {loginUser();},
              child: Container(
                height: 50,
                child: Center(child:
                Text("Zaloguj", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),)),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser(){
    _logRegBloc.loginUser(email.trim(), password.trim());
  }
}
