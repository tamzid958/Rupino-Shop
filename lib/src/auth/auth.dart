import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User> user;
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = _auth.authStateChanges();
  }
  Future<User> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser;
    try {
      googleUser =
          await _googleSignIn.signIn().catchError((Object error) => {});
      if (await _googleSignIn.isSignedIn()) {}
    } catch (error) {}
    if (googleUser == null) return null;
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User user = userCredential.user;
    loading.add(false);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    return user;
  }

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    return _auth.signOut();
  }

  Future<List> getProfile() async {
    User user = FirebaseAuth.instance.currentUser;
    return user.providerData;
  }

  Future<String> currentUser() async {
    User user = FirebaseAuth.instance.currentUser;
    return user != null ? user.uid : null;
  }
}

final AuthService authService = AuthService();
