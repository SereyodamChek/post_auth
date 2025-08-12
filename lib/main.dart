import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:post_auth/view/side_bar_screens/admin/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDX3D4JaygALq1ZBxtYFfbdX506aO0cAcw',
      appId: '1:26654825325:android:4488a26b482297693d1864',
      messagingSenderId: '26654825325',
      projectId: 'post-product-beac8',
      storageBucket: 'post-product-beac8.firebasestorage.app',
    ),
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}