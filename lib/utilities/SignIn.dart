import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

final OAuthProvider appleOAuthProvider = OAuthProvider(providerId: 'apple.com');

// String name;
// String email;
// String imageUrl;

Future<bool> signInWithGoogle() async {
  // try {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  // assert(user.email != null);
  // assert(user.displayName != null);
  // assert(user.photoUrl != null);

  // name = user.displayName;
  // email = user.email;
  // imageUrl = user.photoUrl;

  // Only taking the first part of the name, i.e., First Name
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  // return 'signInWithGoogle succeeded: $user';
  return true;
  // } catch (e) {
  //   print(e);
  //   return (e);
  // }
}

void signOutGoogle() {
  //! MUST SIGNOUT USING BOTH GOOGLE AND FIREBASE
  //? CONTROL FLOW => google signIn then firbase user takes over
  _auth.signOut();
  googleSignIn.signOut();

  print("User Sign Out");
}

Future<bool> signInWithApple() async {
  print("Attempting to sign in with Apple");
  try {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    print(result.status.toString());
    switch (result.status) {
      case AuthorizationStatus.authorized:
        try {
          print("successfull sign in");
          final AppleIdCredential appleIdCredential = result.credential;

          // Create a new Firebase OAuth Provider with Apple.com
          final AuthCredential credential = appleOAuthProvider.getCredential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken),
            accessToken:
                String.fromCharCodes(appleIdCredential.authorizationCode),
          );

          final AuthResult _res = await _auth.signInWithCredential(credential);

          _auth.currentUser().then((val) async {
            UserUpdateInfo updateUser = UserUpdateInfo();
            updateUser.displayName =
                "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
            // updateUser.photoUrl = ;
            await val.updateProfile(updateUser);
          });
          final FirebaseUser user = _res.user;
          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);

          final FirebaseUser currentUser = await _auth.currentUser();
          assert(user.uid == currentUser.uid);
          return true;
        } catch (e) {
          print("error");
          return false;
        }
        break;
      case AuthorizationStatus.error:
        return false;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        return false;
    }
  } catch (error) {
    print("error with apple sign in");

    return false;
  }
  return false;
}

// Future<bool> isSignedIn() async {
//   try{
//     googleSignIn.signInSilently();
//   } catch (e){
//     print("ISSIGNEDIN" + e);
//     return false;
//   }
// }

// Future<bool> signedInAlready() async {
//   final FirebaseUser x = await _auth.currentUser();

//   bool signedIn;

//   if (x != null) {
//     print("user already signed in");
//     signedIn = true;
//   } else {
//     print("user NOT signed in");
//     signedIn = false;
//   }

//   return signedIn;
// }
