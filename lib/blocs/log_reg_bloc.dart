import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mim2/firebase/auth_manager.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LogRegBloc extends BlocBase{

  final firebaseAuthManager = auth_manager();

  BehaviorSubject<String> _messageSubject = BehaviorSubject();
  Stream<String> get messageObservable => _messageSubject.stream;

  BehaviorSubject<FirebaseUser> _currentUserSubject = BehaviorSubject();
  Stream<FirebaseUser> get currentUser => _currentUserSubject.stream;

  BehaviorSubject<bool> _loadingLoginRegisterSubject = BehaviorSubject();
  Stream<bool> get loadingLoginRegister => _loadingLoginRegisterSubject.stream;

  @override
  void dispose(){
    _currentUserSubject.close();
    _messageSubject.close();
    _loadingLoginRegisterSubject.close();
    super.dispose();
  }

  Future checkIfLogged()async {
    firebaseAuthManager.getUser().then((value){
      _currentUserSubject.add(value);
    })
        .catchError((e) {});
  }

  Future registerUser(String email, String password) async{
    _loadingLoginRegisterSubject.add(true);
    firebaseAuthManager.registerUser(email,password)
        .then(_onRegisterSuccess)
        .catchError(_onRegisterFailed);
  }

  // ignore: non_constant_identifier_names
  Future _onRegisterSuccess(FirebaseUser user){
    _loadingLoginRegisterSubject.add(false);
    _messageSubject.add("Zarejestrowano!");
    _currentUserSubject.add(user);
  }

  Future _onRegisterFailed(e){
    _loadingLoginRegisterSubject.add(false);
    _messageSubject.add("Błąd podczas rejestracji!");
  }

  Future loginUser (String email, String password) async{
    _loadingLoginRegisterSubject.add(true);
    firebaseAuthManager.loginUser(email, password)
        .then(_onLoginSuccess)
        .catchError(_onLoginFailed);
  }

  Future _onLoginSuccess(FirebaseUser user){
    _loadingLoginRegisterSubject.add(false);
    _messageSubject.add("Zalogowano poprawnie");
    _currentUserSubject.add(user);
  }

  Future _onLoginFailed(e){
    _loadingLoginRegisterSubject.add(false);
    _messageSubject.add("Wystąpił błąd przy logowaniu... Spróbuj jeszcze raz");
  }
}