import 'package:move_app/provider/bace_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider extends BaceProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;
  Future<bool> login(String email, String password) async {
    SetDone(true);
    UserCredential userCred = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
    if (userCred.user != null) {
      SetDone(false);
      return true;
    } else {
      SetDone(false);
      return false;
    }
  }

  Future<bool> createAccount(String email, String password) async {
    UserCredential userCred = await firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password);
    if (userCred.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    firebaseAuth.signOut();
    return true;
  }
}
