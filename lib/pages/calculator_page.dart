import 'package:calculator/core/color/app_colors.dart';
import 'package:calculator/core/responcive/app_responsive.dart';
import 'package:flutter/material.dart';
import '../helpers/calculator_controller.dart';
import '../widgets/calculator_button.dart';

class CalculatorPage extends StatefulWidget {
  final VoidCallback? onToggleTheme;

  const CalculatorPage({super.key, this.onToggleTheme});

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

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final textColor =
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black;

        if (controller.history.isEmpty) {
          return SizedBox(
            height: appH(200),
            child: Center(
              child: Text(
                'No history',
                style: TextStyle(color: Colors.grey, fontSize: appH(18)),
              ),
            ),
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: appW(16),
                  vertical: appH(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                        color: textColor,
                        fontSize: appH(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(controller.clearHistory);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(color: AppColors.red),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.history.length,
                  itemBuilder: (context, index) {
                    final entry = controller.history[index];
                    return ListTile(
                      title: Text(
                        entry,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: textColor, fontSize: appH(18)),
                      ),
                      onTap: () {
                        setState(() => controller.loadFromHistory(entry));
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = Theme.of(context).colorScheme.primary;
    final defaultText = isDark ? Colors.white : Colors.black;

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
              /// Yuqori panel: tarix va tema tugmalari
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _showHistory,
                    icon: Icon(Icons.history, color: defaultText),
                  ),
                  IconButton(
                    onPressed: widget.onToggleTheme,
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: defaultText,
                    ),
                  ),
                ],
              ),

              /// Ekran (ifoda + jonli natija) — qolgan joyni egallaydi
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Ifoda — joy tor bo'lsa avtomatik kichrayadi
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          controller.expression,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: appH(50),
                            color: defaultText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: appH(6)),

                    /// Jonli natija (kulrang)
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          controller.result,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: appH(40),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    /// Backspace
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => _onPressed('⌫'),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.backspace,
                          size: appH(28),
                          color: defaultText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: appH(15)),

              /// Amallar (foiz, ildiz, daraja, ishora)
              buildButtonRow([
                {'text': '+/-', 'color': AppColors.green},
                {'text': '%', 'color': AppColors.green},
                {'text': '√', 'color': AppColors.green},
                {'text': 'x²', 'color': AppColors.green},
              ]),
              SizedBox(height: appH(10)),

              buildButtonRow([
                {'text': 'C', 'bg': AppColors.red, 'color': Colors.white},
                {'text': '(', 'color': AppColors.green},
                {'text': ')', 'color': AppColors.green},
                {'text': '÷', 'color': AppColors.green},
              ]),
              SizedBox(height: appH(10)),

              buildButtonRow([
                {'text': '7'},
                {'text': '8'},
                {'text': '9'},
                {'text': '×', 'color': AppColors.green},
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
