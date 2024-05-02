import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {

  Future<User?> signInWithEmailPassword(String email, String password);
  Future<User?> registerWithEmailPassword(String email, String password,String phoneNumber,String name);
  Future<User?> signInWithGoogle();
}