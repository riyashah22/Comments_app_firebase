import 'package:comments_app/firebase_options.dart';
import 'package:comments_app/provider/comments_provider.dart';
import 'package:comments_app/view/auth/login_screen.dart';
import 'package:comments_app/view/auth/registration_screen.dart';
import 'package:comments_app/view/comments_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RegistrationScreen(),
        initialRoute: '/register',
        routes: {
          '/register': (context) => const RegistrationScreen(),
          '/login': (context) => const LoginScreen(),
          '/comments': (context) => const CommentsScreen(),
        },
      ),
      create: (context) => CommentsProvider(),
    );
  }
}
