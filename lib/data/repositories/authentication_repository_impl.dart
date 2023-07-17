import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shop_app/data/datasources/firebase_auth_data_source.dart';
import 'package:online_shop_app/data/exception/server_exception.dart';
import 'package:online_shop_app/domain/repositories/authentication_repository.dart';

import '../../utils/failure.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuthDataSource _dataSource;
  AuthenticationRepositoryImpl(this._dataSource);

  @override
  Future<Either<FirebaseAuthenticationFailure, UserCredential>>
      createUserWithEmailAndPassword(String email, String password) async {
    try {
      final user =
          await _dataSource.createUserWithEmailAndPassword(email, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(FirebaseAuthenticationFailure(e.message));
    } catch (ex) {
      return Left(FirebaseAuthenticationFailure(ex.toString()));
    }
  }

  @override
  Future<Either<FirebaseAuthenticationFailure, UserCredential>>
      signInWithEmailAndPassword(String email, String password) async {
    try {
      final user =
          await _dataSource.signInWithEmailAndPassword(email, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(FirebaseAuthenticationFailure(e.message));
    } catch (ex) {
      return Left(FirebaseAuthenticationFailure(ex.toString()));
    }
  }

  @override
  Future<Either<FirebaseAuthenticationFailure, bool>> signOut() async {
    try {
      final result = await _dataSource.signOut();
      return Right(result);
    } on ServerException catch (e) {
      return Left(FirebaseAuthenticationFailure(e.message));
    } catch (ex) {
      return Left(FirebaseAuthenticationFailure(ex.toString()));
    }
  }
}
