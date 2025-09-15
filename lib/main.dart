import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamed_portfolio/controllers/home_controller.dart';
import 'package:hamed_portfolio/controllers/theme_controller.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/screens/home_screen.dart';
import 'package:hamed_portfolio/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hamed Kazemi - Flutter Developer',
      debugShowCheckedModeBanner: false,

      // Localization
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        fontFamily: 'Poppins',
      ),

      // Controllers
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
        Get.put(LanguageController());
        Get.put(HomeController());
      }),

      home: const HomeScreen(),
    );
  }
}
