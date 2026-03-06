import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navigation/app_router.dart';
import 'screens/splash_screen.dart';
import 'screens/receive/receive_menu_screen.dart';
import 'screens/card/card_info_screen.dart';
import 'screens/main/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const TeslaPayApp());
}

class TeslaPayApp extends StatelessWidget {
  const TeslaPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeslaPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F5F7),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFBA08)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F5F7),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF151515)),
        ),
      ),
      home: const SplashScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
