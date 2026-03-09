import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdumb/features/splash/presentation/screens/splash_screen.dart';

/// Entorno: 'stage' o 'prod'. Definir con --dart-define=ENV=stage o ENV=prod
const String _env = String.fromEnvironment('ENV', defaultValue: 'stage');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env.$_env');
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Typo Round',
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Typo Round',
        ),
      ),
      home: const SplashScreen(),
    );
  }
}