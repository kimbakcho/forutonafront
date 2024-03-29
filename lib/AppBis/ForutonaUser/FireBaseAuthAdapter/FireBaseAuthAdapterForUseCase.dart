import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:injectable/injectable.dart';

import 'FireBaseAuthBaseAdapter.dart';

abstract class FireBaseAuthAdapterForUseCase
    extends FireBaseAuthBaseAdapter {
  void startOnAuthStateChangedListen();
}
@LazySingleton(as: FireBaseAuthAdapterForUseCase)
class FireBaseAuthAdapterForUseCaseImpl
    implements FireBaseAuthAdapterForUseCase {

  final FireBaseMessageAdapter _fireBaseMessageAdapter;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  final UpdateFCMTokenUseCaseInputPort _updateFCMTokenUseCaseInputPort;


  FireBaseAuthAdapterForUseCaseImpl(
      {required FireBaseMessageAdapter fireBaseMessageAdapter,
      required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter,
      required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      required UpdateFCMTokenUseCaseInputPort updateFCMTokenUseCaseInputPort
      })
      : _fireBaseMessageAdapter = fireBaseMessageAdapter,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _updateFCMTokenUseCaseInputPort = updateFCMTokenUseCaseInputPort,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort;


  startOnAuthStateChangedListen(){
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChange);
  }

  Future<String> getFireBaseIdToken() async {
   return await _fireBaseAuthBaseAdapter.getFireBaseIdToken();
  }

  Future<bool> isLogin() async {
    return await _fireBaseAuthBaseAdapter.isLogin();
  }

  Future<String> userUid() async {
    return await _fireBaseAuthBaseAdapter.userUid();
  }

  _onAuthStateChange(User? user) async {
    if(await isLogin()){
      await _signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer();
      await _updateFCMTokenUseCaseInputPort.updateFCMToken((await _fireBaseMessageAdapter.getCurrentToken())!);
    } else {
      _signInUserInfoUseCaseInputPort.clearUserInfo();
    }
  }



  @override
  Future<String?> userEmail() async {
    return await _fireBaseAuthBaseAdapter.userEmail();
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String pw) async {
    return await _fireBaseAuthBaseAdapter.signInWithEmailAndPassword(email, pw);
  }

  @override
  Future<List<String>> fetchSignInMethodsForEmail(String email) async {
    return await _fireBaseAuthBaseAdapter.fetchSignInMethodsForEmail(email);
  }

  @override
  Future<String> signInWithCustomToken(String token) async {
    return await _fireBaseAuthBaseAdapter.signInWithCustomToken(token);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _fireBaseAuthBaseAdapter.sendPasswordResetEmail(email);
  }

  @override
  Future<void> logout() async{
    return await _fireBaseAuthBaseAdapter.logout();
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String pw) async {
    return await _fireBaseAuthBaseAdapter.createUserWithEmailAndPassword(email, pw);
  }


}
