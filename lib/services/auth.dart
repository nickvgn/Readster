import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Future<String> get getPhotoUrl =>
      _auth.currentUser().then((value) => value.photoUrl);
  Future<String> get getUserName =>
      _auth.currentUser().then((value) => value.displayName);
  Future<String> get getUserId =>
      _auth.currentUser().then((value) => value.uid);

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() {
    _googleSignIn.signOut();
    return _auth.signOut();
  }
}
