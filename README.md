# CalcMate

A simple and clean calculator app built with Flutter. Clean architecture,
live calculation, calculation history, and light/dark theme support.

## Features

- Basic operations: `+`, `−`, `×`, `÷`, parentheses `( )`, and decimal numbers
- Extra operations: percent `%`, square root `√`, square `x²`, sign toggle `+/−`
- **Live result** — the answer is shown before pressing `=`
- **Calculation history** — past calculations are saved and can be reused by tapping
- **Light / Dark theme** — toggled via the button at the top
- Input protection: consecutive operators, double decimal points, division by zero

## Project structure

```
lib/
├── main.dart                       # Entry point
├── app.dart                        # MaterialApp + theme state
├── pages/
│   └── calculator_page.dart        # Main UI
├── helpers/
│   └── calculator_controller.dart  # Calculation logic (separated from UI)
├── widgets/
│   └── calculator_button.dart      # Reusable button
└── core/
    ├── color/app_colors.dart       # Colors
    ├── theme/theme.dart            # Light/Dark themes
    └── responcive/app_responsive.dart  # Responsive sizing
```

The calculation logic (`CalculatorController`) is fully separated from the UI,
which is why it is covered by unit tests.

## Getting started

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

There are 18 unit tests for the controller logic (`test/`).

## Packages used

- [`math_expressions`](https://pub.dev/packages/math_expressions) — parsing and
  evaluating mathematical expressions
- `cupertino_icons`

---

Application ID: `com.bit_vant.calcmate`
