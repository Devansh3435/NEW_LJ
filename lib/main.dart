import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_lj/Screens/AuthenticatedScreen.dart';
import 'package:new_lj/Screens/login_screen.dart';
import 'package:new_lj/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New LJ Documents',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoginScreen(),
      initialRoute: '/',
      routes: {
        '/authenticated': (context) => AuthenticatedScreen(),
        'pdfPage': (context) => AuthenticatedScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Unknown Route: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}

