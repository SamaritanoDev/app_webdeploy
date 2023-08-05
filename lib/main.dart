import 'package:app_webdeploy/presentation/screens/home_screen.dart';
import 'package:app_webdeploy/presentation/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  var firebaseConfig = {
    "apiKey": dotenv.env['API_KEY'],
    "authDomain": dotenv.env['AUTH_DOMAIN'],
    "projectId": dotenv.env['PROJECT_ID'],
    "storageBucket": dotenv.env['STORAGE_BUCKET'],
    "messagingSenderId": dotenv.env['MESSAGING_SENDER_ID'],
    "appId": dotenv.env['APP_ID']
  };

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: firebaseConfig["apiKey"]!,
        authDomain: firebaseConfig["authDomain"]!,
        projectId: firebaseConfig["projectId"]!,
        storageBucket: firebaseConfig["storageBucket"]!,
        messagingSenderId: firebaseConfig["messagingSenderId"]!,
        appId: firebaseConfig["appId"]!,
      ),
    );
  } catch (error) {
    print('Error en la inicialización de Firebase: $error');
  }

  runApp(MainApp(fireconfig: firebaseConfig.toString()));
}

class MainApp extends StatelessWidget {
  final String fireconfig;

  const MainApp({super.key, required this.fireconfig});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
      ),
      initialRoute: '/login',
      home: Text(fireconfig),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
