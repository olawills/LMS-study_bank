import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/firebase_refer.dart';
import 'package:study_bank/mobileLayout/widgets/dialogs/app_dialog.dart';
import 'package:study_bank/models/user_model.dart';
import 'package:study_bank/screens/home_screen/home_screen.dart';
import 'package:study_bank/screens/login/login_screen.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;
  GoogleSignInAccount? googleSignInAccount;
  final googleSignIn = GoogleSignIn();

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    googleSignInAccount = googleUser;
    final googleAuth = await googleUser.authentication;

    final cred = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // await _auth.signInWithCredential(cred);

    // navigateToHomePage();
    try {
      await _auth.signInWithCredential(cred).then((res) async {
        log('Signed in Successfully as ${res.user!.displayName.toString()}');
        log('email ${res.user!.email.toString()}');
        // await saveUser(account);
        UserModel newUser = UserModel(
          userUid: res.user!.uid,
          email: res.user!.email!,
          displayName: res.user!.displayName!,
          photoUrl: res.user!.photoURL!,
        );
        _addUserToFirebase(newUser, res.user!);
        navigateToHomePage();
      });
    } catch (error) {
      log(error.toString());
      Get.snackbar('Sign in Failed', 'Please try some other time');
    }
    // try {
    //   GoogleSignInAccount? account = await googleSignIn.signIn();
    //   if (account != null) {
    //     final authAccount = await account.authentication;
    //     final credential = GoogleAuthProvider.credential(
    //       idToken: authAccount.idToken,
    //       accessToken: authAccount.accessToken,
    //     );
    //     await _auth.signInWithCredential(credential);
    //     await saveUser(account);
    //     navigateToHomePage();
    //   }
    // } on Exception catch (error) {
    //   log(error.toString());
    // }
  }

  // saveUser(GoogleSignInAccount account) {
  //   userRf.doc(account.email).set({
  //     'email': account.email,
  //     'name': account.displayName,
  //     'profilepic': account.photoUrl,
  //   });
  //   // print(account.email);
  //   // print(account.displayName);
  // }
  saveUser(UserModel user) {
    userRf.doc(user.userUid).set({
      'email': user.email,
      'name': user.displayName,
      'profilepic': user.photoUrl,
    });
  }

  _addUserToFirebase(UserModel user, User firebaseUser) {
    saveUser(user);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      navigateToHomePage();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.questionDialog(
        onTap: () {
          Get.back();
          navigateToLoginScreen();
          // Navigate to login page
        },
      ),
      // barrierDismissible: false,
    );
  }

  void showLogoutDialog() {
    Get.dialog(Dialogs.logutDialog(onTap: () async {
      Get.back();
      await _auth.signOut();
    }));
  }

  void navigateToLoginScreen() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
