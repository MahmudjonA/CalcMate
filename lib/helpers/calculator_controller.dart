import 'package:math_expressions/math_expressions.dart';

class CalculatorController {
  String expression = '';
  String result = '';

  /// Bajarilgan hisoblar tarixi ("ifoda = natija"), eng yangisi boshida.
  final List<String> history = [];

  /// '=' bosilgandan keyingi holat. Keyingi raqam yangi ifoda boshlaydi,
  /// keyingi amal esa natijadan davom ettiradi.
  bool _justEvaluated = false;

  static const List<String> _operators = ['+', '-', '×', '÷'];

  void onPressed(String value) {
    switch (value) {
      case 'C':
        expression = '';
        result = '';
        _justEvaluated = false;
        break;
      case '⌫':
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
        _justEvaluated = false;
        _updateLive();
        break;
      case '=':
        _commitResult();
        break;
      case '+/-':
        _toggleSign();
        _justEvaluated = false;
        _updateLive();
        break;
      default:
        _handleInput(value);
        _updateLive();
    }
  }

  void _handleInput(String value) {
    if (_justEvaluated) {
      _justEvaluated = false;
      // Raqam/qavs/funksiya bosilsa — yangi ifoda; amal bosilsa — davom.
      if (!_operators.contains(value)) {
        expression = '';
      }
    }

    if (_operators.contains(value)) {
      _appendOperator(value);
    } else if (value == '.') {
      _appendDecimal();
    } else if (value == '√') {
      expression += 'sqrt(';
    } else if (value == 'x²') {
      expression += '^2';
    } else {
      // Raqam, '%', '(' yoki ')'
      expression += value;
    }
  }

  void _appendOperator(String value) {
    if (expression.isEmpty) {
      // Faqat manfiy ishora ('-') bilan boshlashga ruxsat.
      if (value == '-') expression = '-';
      return;
    }
    final last = expression[expression.length - 1];
    if (_operators.contains(last)) {
      // Ketma-ket amal — oxirgisini almashtiramiz (5+* -> 5*).
      expression = expression.substring(0, expression.length - 1) + value;
    } else {
      expression += value;
    }
  }

  void _appendDecimal() {
    // Joriy sondagi ikkinchi nuqtani bloklaymiz (1.2.3 bo'lmasin).
    final lastNumber = RegExp(r'[0-9.]*$').firstMatch(expression)!.group(0)!;
    if (lastNumber.contains('.')) return;

    if (expression.isEmpty ||
        _operators.contains(expression[expression.length - 1]) ||
        expression.endsWith('(')) {
      expression += '0.';
    } else {
      expression += '.';
    }
  }

  void _toggleSign() {
    // Oldin o'ralgan bo'lsa (-son) — ochamiz.
    final wrapped = RegExp(r'\(-(\d+\.?\d*)\)$').firstMatch(expression);
    if (wrapped != null) {
      expression = expression.substring(0, wrapped.start) + wrapped.group(1)!;
      return;
    }
    // Oxirgi sonni (-son) ko'rinishida o'raymiz.
    final plain = RegExp(r'(\d+\.?\d*)$').firstMatch(expression);
    if (plain != null && plain.group(0)!.isNotEmpty) {
      expression =
          '${expression.substring(0, plain.start)}(-${plain.group(0)})';
    }
  }

  void _commitResult() {
    final value = _evaluate(expression);
    if (value == null) {
      if (expression.isNotEmpty) result = 'Error';
      return;
    }
    history.insert(0, '$expression = $value');
    expression = value;
    result = '';
    _justEvaluated = true;
  }

  void _updateLive() {
    result = _evaluate(expression) ?? '';
  }

  /// Ifodani baholaydi. Xato / bo'sh / cheksiz bo'lsa null qaytaradi.
  String? _evaluate(String expr) {
    if (expr.trim().isEmpty) return null;
    try {
      final parsed = GrammarParser().parse(
        expr
            .replaceAll('×', '*')
            .replaceAll('÷', '/')
            .replaceAll('%', '/100'),
      );
      final value = RealEvaluator(ContextModel()).evaluate(parsed);
      if (value is! double || !value.isFinite) return null; // 5/0 -> null
      return _format(value);
    } catch (_) {
      return null;
    }
  }

  String _format(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    var text = value.toStringAsFixed(8);
    text = text.replaceAll(RegExp(r'0+$'), '');
    text = text.replaceAll(RegExp(r'\.$'), '');
    return text;
  }

  /// Tarixdagi yozuvni ifodaga qaytaradi ("2+3 = 5" -> "2+3").
  void loadFromHistory(String entry) {
    expression = entry.split(' = ').first;
    result = '';
    _justEvaluated = false;
    _updateLive();
  }

  void clearHistory() => history.clear();
}
