import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthController extends GetxController {
  late FirebaseAuth firebaseAuth;

  String email = '';
  String password = '';

  final loginForm = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password': FormControl(validators: [Validators.required])
  });

  final resetForm = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email])
  });

  @override
  void onInit() {
    super.onInit();

    firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.authStateChanges().listen((event) {
      print(event);
    }, onDone: () {
      print('done auth');
    }, onError: (error) {
      print(error);
    });
  }

  void signInWithEmailAndPassword() {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredencial) {
      // TODO: ler permissoes
    }).catchError((error) {
      throw error;
    });
  }

  void register() {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredencial) {
      // TODO: ler permissoes
    }).catchError((error) {
      throw error;
    });
  }

  void reset() {
    firebaseAuth.sendPasswordResetEmail(email: email).then((userCredencial) {
      // TODO: ler permissoes
    }).catchError((error) {
      throw error;
    });
  }

  void signIn() {}
}
