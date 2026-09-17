import 'package:calculator/core/theme/theme.dart';
import 'package:calculator/pages/calculator_page.dart';
import 'package:flutter/material.dart';
import 'core/responcive/app_responsive.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _themeMode,
      home: CalculatorPage(onToggleTheme: _toggleTheme),
    );
  }
}
