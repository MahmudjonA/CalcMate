import 'package:flutter/material.dart';

import '../core/responcive/app_responsive.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const CalcButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: appW(10),top: appH(9),),
        height: appH(80),
        width: appW(80),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(appH(15)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: appH(30),
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
