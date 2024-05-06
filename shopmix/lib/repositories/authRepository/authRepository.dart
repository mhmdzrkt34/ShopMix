import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopmix/repositories/authRepository/IAuthRepository.dart';

class AuthRepository extends IAuthRepository {

  Future<User?> registerWithEmailPassword(String email, String password,String phoneNumber,String name) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    var user = userCredential.user;

     CollectionReference users=FirebaseFirestore.instance.collection("users");
     await users.add({
      "Email":email.toLowerCase(),
"Name":name,
"Password":password,

"PhoneNumber":phoneNumber

     });


    return user;


  } on FirebaseAuthException catch (e) {
    return null;
  }
}

Future<User?> signInWithEmailPassword(String emaill, String passwordd) async {
try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emaill,
    password: passwordd,
  );
  return credential.user;
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Invaled Credentials');
  }
}}

Future<User?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Firebase sign in
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }
  return null;
}



//on FirebaseAuthException

}