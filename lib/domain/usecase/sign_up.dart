import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shop_app/domain/repositories/authentication_repository.dart';
import 'package:online_shop_app/utils/failure.dart';

class SignUp {
  final AuthenticationRepository repository;

  SignUp(this.repository);
  Future<Either<Failure, UserCredential>> execute(
      String email, String password) async {
    return await repository.createUserWithEmailAndPassword(email, password);
  }
}
