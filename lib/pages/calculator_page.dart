import 'package:calculator/core/color/app_colors.dart';
import 'package:calculator/core/responcive/app_responsive.dart';
import 'package:flutter/material.dart';
import '../helpers/calculator_controller.dart';
import '../widgets/calculator_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final controller = CalculatorController();

  void _onPressed(String value) {
    setState(() {
      controller.onPressed(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).colorScheme.surface == Colors.white;
    final defaultBg = Theme.of(context).colorScheme.primary;
    final defaultText = isLightTheme ? Colors.black : Colors.white;

    Widget buildButtonRow(List<Map<String, dynamic>> buttons) {
      return Row(
        children:
            buttons
                .map(
                  (btn) => Padding(
                    padding: EdgeInsets.only(right: appW(9)),
                    child: CalcButton(
                      text: btn['text'],
                      onTap: () => _onPressed(btn['text']),
                      backgroundColor: btn['bg'] ?? defaultBg,
                      textColor: btn['color'] ?? defaultText,
                    ),
                  ),
                )
                .toList(),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(appH(15.0)),
          child: Column(
            children: [
              /// Expression
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        controller.expression,
                        style: TextStyle(
                          fontSize: appH(50),
                          color: defaultText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: appH(100)),

              /// Result
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    controller.result,
                    style: TextStyle(fontSize: appH(40), color: defaultText),
                  ),
                ],
              ),

              /// Backspace
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _onPressed('⌫'),
                    icon: Icon(
                      Icons.backspace,
                      size: appH(30),
                      color: defaultText,
                    ),
                  ),
                ],
              ),

              SizedBox(height: appH(20)),
              const Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: appH(20)),

              /// Buttons
              buildButtonRow([
                {'text': 'C', 'bg': AppColors.red, 'color': defaultText},
                {'text': '(', 'color': AppColors.green},
                {'text': ')', 'color': AppColors.green},
                {'text': '/', 'color': AppColors.green},
              ]),
              SizedBox(height: appH(10)),

              buildButtonRow([
                {'text': '7'},
                {'text': '8'},
                {'text': '9'},
                {'text': '*', 'color': AppColors.green},
              ]),
              SizedBox(height: appH(10)),

              buildButtonRow([
                {'text': '4'},
                {'text': '5'},
                {'text': '6'},
                {'text': '-', 'color': AppColors.green},
              ]),
              SizedBox(height: appH(10)),

              buildButtonRow([
                {'text': '1'},
                {'text': '2'},
                {'text': '3'},
                {'text': '+', 'color': AppColors.green},
              ]),
              SizedBox(height: appH(10)),

              Row(
                children: [
                  CalcButton(
                    text: '0',
                    onTap: () => _onPressed('0'),
                    backgroundColor: defaultBg,
                    textColor: defaultText,
                  ),
                  SizedBox(width: appW(10)),
                  CalcButton(
                    text: '.',
                    onTap: () => _onPressed('.'),
                    backgroundColor: defaultBg,
                    textColor: defaultText,
                  ),
                  SizedBox(width: appW(10)),
                  SizedBox(
                    width: appW(190),
                    child: CalcButton(
                      text: '=',
                      onTap: () => _onPressed('='),
                      backgroundColor: AppColors.green,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
