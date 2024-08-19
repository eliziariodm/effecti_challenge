import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.white,
          tertiary: Colors.black,
          secondaryContainer: Colors.grey,
          error: Colors.red,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            size: 28,
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
