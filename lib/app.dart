import 'package:calculator/core/theme/theme.dart';
import 'package:calculator/pages/calculator_page.dart';
import 'package:flutter/material.dart';
import 'core/responcive/app_responsive.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: CalculatorPage(),
    );
  }
}
