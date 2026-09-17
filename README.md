# CalcMate

Flutter’da yozilgan sodda va chiroyli kalkulyator ilovasi. Toza arxitektura,
jonli hisoblash, hisoblar tarixi va light/dark tema qo‘llab-quvvatlaydi.

## Imkoniyatlar

- Asosiy amallar: `+`, `−`, `×`, `÷`, qavslar `( )` va kasr sonlar
- Qo‘shimcha amallar: foiz `%`, kvadrat ildiz `√`, kvadrat `x²`, ishora `+/−`
- **Jonli natija** — `=` bosmasdan turib javob ko‘rinib turadi
- **Hisoblar tarixi** — bajarilgan amallar saqlanadi, bosib qayta yuklash mumkin
- **Light / Dark tema** — yuqoridagi tugma orqali almashtiriladi
- Xato kiritishdan himoya: ketma-ket amallar, ikkita nuqta, nol ustiga bo‘lish

## Loyiha tuzilmasi

```
lib/
├── main.dart                       # Kirish nuqtasi
├── app.dart                        # MaterialApp + tema holati
├── pages/
│   └── calculator_page.dart        # Asosiy UI
├── helpers/
│   └── calculator_controller.dart  # Hisoblash mantig'i (UI'dan ajratilgan)
├── widgets/
│   └── calculator_button.dart      # Qayta ishlatiladigan tugma
└── core/
    ├── color/app_colors.dart       # Ranglar
    ├── theme/theme.dart            # Light/Dark temalar
    └── responcive/app_responsive.dart  # Ekranga moslashuvchi o'lchamlar
```

Hisoblash mantig‘i (`CalculatorController`) UI’dan to‘liq ajratilgan, shuning
uchun unit testlar bilan qamrab olingan.

## Ishga tushirish

```bash
flutter pub get
flutter run
```

## Testlar

```bash
flutter test
```

Controller mantig‘i uchun 18 ta unit test mavjud (`test/`).

## Ishlatilgan paketlar

- [`math_expressions`](https://pub.dev/packages/math_expressions) — matematik
  ifodalarni tahlil qilish va hisoblash
- `cupertino_icons`

---

Ilova identifikatori: `com.bit_vant.calcmate`
