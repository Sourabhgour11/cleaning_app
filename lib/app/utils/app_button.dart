import 'package:flutter/material.dart';

import 'app_colours.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
     this.icon,
  });
  final Function() onPressed;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 90 / 100,
      height: MediaQuery.of(context).size.height * 7 / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: AppColours.gradientColor,
        boxShadow: [
          BoxShadow(
            color: AppColours.appColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColours.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           icon!=null ? Icon(icon, size: 20, color: AppColours.white):SizedBox(),
            icon!=null ? SizedBox(width: 8):SizedBox(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
