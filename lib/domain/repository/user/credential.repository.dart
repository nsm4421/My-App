import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/model/response/response.model.dart';

import '../../entity/user/user.entity.dart';

abstract class CredentialRepository {
  // 인증 상태
  bool get isAuthenticated;

  // 현재 로그인한 유저 id
  String? get currentUid;

  Stream<User?> get currentUserStream;

  // 로그아웃
  Future<ResponseModel<void>> signOut();

  // 구글계정으로 회원가입
  Future<ResponseModel<UserEntity>> googleSignIn();

  // 이메일, 패스워드 회원가입
  Future<ResponseModel<void>> signUpWithEmailAndPassword(
      {required String email, required String password});

  // 이메일, 패스워드 로그인
  Future<ResponseModel<UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});
}
