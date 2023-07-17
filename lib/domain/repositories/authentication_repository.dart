import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shop_app/utils/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<FirebaseAuthenticationFailure, UserCredential>>
      signInWithEmailAndPassword(String email, String password);

  Future<Either<FirebaseAuthenticationFailure, UserCredential>>
      createUserWithEmailAndPassword(String email, String password);

  Future<Either<FirebaseAuthenticationFailure, bool>> signOut();
}
