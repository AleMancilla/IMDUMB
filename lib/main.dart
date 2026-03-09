import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdumb/features/movies/data/datasources/local/movie_local_datasource_impl.dart';
import 'package:imdumb/features/movies/presentation/providers/movie_provider.dart';
import 'package:imdumb/features/splash/presentation/screens/splash_screen.dart';

/// Entorno: 'stage' o 'prod'. Definir con --dart-define=ENV=stage o ENV=prod
const String _env = String.fromEnvironment('ENV', defaultValue: 'stage');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env.$_env');
  await Firebase.initializeApp();
  await Hive.initFlutter();
  final movieCacheBox = await MovieLocalDatasourceImpl.openBox();

  runApp(
    ProviderScope(
      overrides: [
        movieCacheBoxProvider.overrideWithValue(movieCacheBox),
      ],
      child: const MyApp(),
    ),
  );
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