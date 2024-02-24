import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class GoogleSignUpUseCase {
  final CredentialRepository _repository;

  GoogleSignUpUseCase(this._repository);

  Future<UserCredential> call() async => await _repository.googleSignIn();
}
