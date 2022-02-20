import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/Models/UserModel.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userModel(User? user) {
    if (user != null) {
      return UserModel(
          uid: user.uid,
          name: user.displayName,
          emailVerified: user.emailVerified);
    } else {
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      user = await updateUser(user);
      if (user!.emailVerified) {
        return _userModel(user);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Stream<UserModel?> get currentUser {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userModel(user));
        .map(_userModel);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future register(String email, String password, String? name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        await user.updateDisplayName(name);
        return _userModel(user);
      }
    } catch (e) {
      print(e.hashCode.toString());
      return null;
    }
  }

  Future<User?> updateUser(User? user) async {
    await user!.reload();
    User? user1 = user;
    return user1;
  }
}
