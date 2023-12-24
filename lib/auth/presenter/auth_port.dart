abstract class AuthPort {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signInWithApple();
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> isSignedIn();
  Future<String> getUser();
  Future<String> getToken();
  Future<void> delete();
}
