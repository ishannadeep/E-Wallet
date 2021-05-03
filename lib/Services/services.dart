import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference _users = FirebaseFirestore.instance.collection('users');
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> register(
    {String firstname,
    String lastname,
    String birthday,
    String nicnum,
    String contactnum,
    String address,
    String email,
    String password}) async {
  try {
    print("register");
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Register result: ${result.user.uid}");

    _users
        .doc(result.user.uid)
        .set({
          'firstname': firstname, // John Doe
          'lastname': lastname, // Stokes and Sons
          'birthday': birthday,
          'nicnum': nicnum,
          'contactnum': contactnum,
          'address': address,
          'email': email,
          'password': password, // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> signin(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("loged in sucessfully, user : ${result.user.uid}");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print("user-not-found");
      return 'user-not-found';
    } else if (e.code == 'wrong-password') {
      print("wrong-password");
      return 'wrong-password';
    }
  }
}

Future signout() async {
  await _auth.signOut();
}
