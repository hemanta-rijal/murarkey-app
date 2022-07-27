import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 9/12/2021.
 */
class GoogleSignInProvider {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future googleLoginFromFirebase() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    print(
        "accessToken= ${googleAuth.accessToken}\nidToken= ${googleAuth.idToken}");

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }

  Future<String> googleLoginFromUrl() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return "";
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    print(
        "accessToken= ${googleAuth.accessToken}\nidToken= ${googleAuth.idToken}");
    return googleAuth.accessToken;
  }

  Future googleLogout() async {
    if (googleSignIn != null) {
      final googleUser = await googleSignIn.signOut();
    }
  }
}
