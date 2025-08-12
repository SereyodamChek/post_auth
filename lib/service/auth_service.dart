import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    String res = "Some error occurred",
  }) async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return "Please fill in all fields";
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'uid': userCredential.user?.uid,
      });

      // ✅ Return string to indicate success
      return "successfully signed up";
    } catch (e) {
      print(e.toString());
      return e.toString(); // return error message
    }
  }

 Future<String> loginUser({
  required String email,
  required String password,
}) async {
  String res = "Some error occurred";
  try {
    // ✅ Check for empty fields first
    if (email.isEmpty || password.isEmpty) {
      return "Please enter both email and password";
    }

    // ✅ Attempt sign in
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    res = "successfully logged in";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      res = "User not found";
    } else if (e.code == 'wrong-password') {
      res = "Incorrect password";
    } else {
      res = e.message ?? "Authentication error";
    }
  } catch (e) {
    print(e.toString());
    res = "An unexpected error occurred";
  }
  return res;
}

}
