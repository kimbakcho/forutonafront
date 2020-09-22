import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';


abstract class FireBaseAuthBaseAdapter {
  Future<String> getFireBaseIdToken();
  Future<bool> isLogin();
  Future<String> userUid();
  Future<String> userEmail();
  Future<String> signInWithEmailAndPassword(String email,String pw);
  Future<List<String>> fetchSignInMethodsForEmail(String email);
  Future<String> signInWithCustomToken(String token);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> logout();
  Future<String> createUserWithEmailAndPassword(String email,String pw);
}
@Injectable(as: FireBaseAuthBaseAdapter)
class FireBaseAuthBaseAdapterImpl implements FireBaseAuthBaseAdapter {
  final noneToken = "noneToken";

  Future<String> getFireBaseIdToken() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser == null) {
      return noneToken;
    }
    var idTokenResult = await firebaseUser.getIdToken(refresh: true);
    return idTokenResult.token;
  }

  Future<bool> isLogin() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> userUid() async {
    if (await isLogin()) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      return firebaseUser.uid;
    } else {
      throw new FireBaseAdapterException("no Login statue");
    }
  }

  @override
  Future<String> userEmail() async {
    if (await isLogin()) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      return firebaseUser.email;
    }else {
      throw new FireBaseAdapterException("no Login statue");
    }
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String pw) async {
    AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pw);
    return result.user.uid;
  }

  @override
  Future<List<String>> fetchSignInMethodsForEmail(String email) async {
     return await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);
  }

  @override
  Future<String> signInWithCustomToken(String token) async {
    var authResult = await FirebaseAuth.instance.signInWithCustomToken(token: token);
    return authResult.user.uid;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email,String pw) async{
    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pw);
    return result.user.uid;
  }

}

class FireBaseAdapterException implements Exception {
  String errMsg;

  FireBaseAdapterException(this.errMsg);
}
