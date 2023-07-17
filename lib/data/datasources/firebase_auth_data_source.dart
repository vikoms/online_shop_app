import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shop_app/data/exception/server_exception.dart';

abstract class FirebaseAuthDataSource {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password);

  Future<bool> signOut();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthDataSourceImpl(this._firebaseAuth);
  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Failed to login...");
    } catch (ex) {
      throw ServerException(ex.toString());
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Failed to login...");
    } catch (ex) {
      throw ServerException(ex.toString());
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Failed to login...");
    } catch (ex) {
      throw ServerException(ex.toString());
    }
  }
}
