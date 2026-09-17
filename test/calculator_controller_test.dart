import 'package:calculator/helpers/calculator_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CalculatorController c;

  setUp(() => c = CalculatorController());

  void type(String keys) {
    for (final k in keys.split('')) {
      c.onPressed(k);
    }
  }

  group('Asosiy amallar', () {
    test('qo\'shish', () {
      type('2+3');
      expect(c.result, '5'); // jonli natija
      c.onPressed('=');
      expect(c.expression, '5');
    });

    test('bo\'lish (kasr natija)', () {
      type('10÷4');
      c.onPressed('=');
      expect(c.expression, '2.5');
    });

    test('qavslar', () {
      type('(2+3)×4');
      c.onPressed('=');
      expect(c.expression, '20');
    });
  });

  group('Validatsiya', () {
    test('ketma-ket amal oxirgisini almashtiradi', () {
      type('5+');
      c.onPressed('×');
      expect(c.expression, '5×');
    });

    test('bir sonda ikkita nuqta bo\'lmaydi', () {
      type('1.2');
      c.onPressed('.');
      expect(c.expression, '1.2');
    });

    test('amaldan keyin nuqta 0. beradi', () {
      type('5+');
      c.onPressed('.');
      expect(c.expression, '5+0.');
    });

    test('nol ustiga bo\'lish Error beradi, crash emas', () {
      type('5÷0');
      c.onPressed('=');
      expect(c.result, 'Error');
    });
  });

  group('Yangi amallar', () {
    test('foiz', () {
      type('50%');
      c.onPressed('=');
      expect(c.expression, '0.5');
    });

    test('ildiz', () {
      c.onPressed('√');
      type('9)');
      c.onPressed('=');
      expect(c.expression, '3');
    });

    test('kvadrat', () {
      type('5');
      c.onPressed('x²');
      c.onPressed('=');
      expect(c.expression, '25');
    });

    test('ishorani almashtirish va qaytarish', () {
      type('5');
      c.onPressed('+/-');
      expect(c.expression, '(-5)');
      c.onPressed('+/-');
      expect(c.expression, '5');
    });
  });

  group('Tahrirlash', () {
    test('backspace', () {
      type('12');
      c.onPressed('⌫');
      expect(c.expression, '1');
    });

    test('tozalash', () {
      type('12+3');
      c.onPressed('C');
      expect(c.expression, '');
      expect(c.result, '');
    });
  });

  group('= dan keyingi holat', () {
    test('amal natijadan davom ettiradi', () {
      type('2+3');
      c.onPressed('=');
      type('+2');
      c.onPressed('=');
      expect(c.expression, '7');
    });

    test('raqam yangi ifoda boshlaydi', () {
      type('2+3');
      c.onPressed('=');
      c.onPressed('7');
      expect(c.expression, '7');
    });
  });

  group('Tarix', () {
    test('= tarixga yozadi', () {
      type('2+3');
      c.onPressed('=');
      expect(c.history.first, '2+3 = 5');
    });

    test('tarixdan yuklash', () {
      type('2+3');
      c.onPressed('=');
      c.loadFromHistory('2+3 = 5');
      expect(c.expression, '2+3');
    });

    test('tarixni tozalash', () {
      type('2+3');
      c.onPressed('=');
      c.clearHistory();
      expect(c.history, isEmpty);
    });
  });
}
