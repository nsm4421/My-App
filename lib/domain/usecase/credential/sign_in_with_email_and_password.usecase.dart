import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class SignInWithEmailAndPasswordUseCase {
  final CredentialRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<ResultEntity<UserEntity>> call(
          {required String email, required String password}) async =>
      await _repository
          .signInWithEmailAndPassword(email: email, password: password)
          .then(ResultEntity<UserEntity>.fromResponse);
}
