import 'package:caixabios/cashflow_app.dart' as cashflow;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyBQOX97p0660aJGsa5SQVoU3_qZChjw-tc",
    authDomain: "cashflow-b1b18.firebaseapp.com",
    databaseURL: "https://cashflow-b1b18-default-rtdb.firebaseio.com",
    projectId: "cashflow-b1b18",
    storageBucket: "cashflow-b1b18.appspot.com",
    messagingSenderId: "126474088672",
    appId: "1:126474088672:web:a27b455c8cc23861bc6085"
  );
  await Firebase.initializeApp(
    options: firebaseOptions);
  
  runApp(cashflow.app);
}
