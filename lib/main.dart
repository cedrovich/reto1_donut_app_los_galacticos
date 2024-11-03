import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto1_donut_app_ulises_millan/pages/login_page.dart'; // Importa la página de inicio de sesión
import 'package:reto1_donut_app_ulises_millan/utils/cart.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          const LoginPage(), // Cambiado para que inicie en la página de inicio de sesión
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.pink,
        ),
      ),
    );
  }
}
