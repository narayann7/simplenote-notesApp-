import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nodepad/screens/login.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  print(googleSignInAccount.email);

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // try {
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);

    user = userCredential.user;
    loginsc.loogin = true;
    print(user.email);
    print("hello bitch");
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'account-exists-with-different-credential') {
    //     // handle the error here
    //   } else if (e.code == 'invalid-credential') {
    //     // handle the error here
    //   }
    // } catch (e) {
    //   // handle the error here
    // }
  }
  return user;
}
