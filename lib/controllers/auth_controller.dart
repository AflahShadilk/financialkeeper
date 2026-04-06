import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: []);

  var isLoading = false.obs;
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    user.bindStream(auth.authStateChanges());
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      Get.offAllNamed('/goal');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
    Get.offAllNamed('/login');
  }
}
