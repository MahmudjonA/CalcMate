import 'package:math_expressions/math_expressions.dart';

class CalculatorController {
  String expression = '';
  String result = '';

  void onPressed(String value) {
    if (value == 'C') {
      expression = '';
      result = '';
    } else if (value == '=') {
      _calculateResult();
    } else if (value == '⌫') {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    } else {
      expression += value;
    }
  }

  void _calculateResult() {
    try {
      final parser = Parser();
      final exp = parser.parse(
        expression.replaceAll('×', '*').replaceAll('÷', '/'),
      );
      final contextModel = ContextModel();
      final eval = exp.evaluate(EvaluationType.REAL, contextModel);

      if (eval == eval.toInt()) {
        result = eval.toInt().toString();
      } else {
        result = eval.toString();
      }
    } catch (e) {
      result = 'Error';
    }
  }

}
