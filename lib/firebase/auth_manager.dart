import 'package:firebase_auth/firebase_auth.dart';

class auth_manager{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> registerUser(String email, String password)  =>
      _auth.createUserWithEmailAndPassword(email: email, password: password).then((result) => result.user);

  Future<FirebaseUser> getUser() async {
    return (await _auth.currentUser());
  }

  Future<FirebaseUser> loginUser(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password).then((result) => result.user);
}