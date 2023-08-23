import 'package:banking_app_ui/config/config.dart';
import 'package:banking_app_ui/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion/motion.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(45.fps);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banking App',
      theme: themeData(context),
      home: const MainScreen(),
    );
  }
}
