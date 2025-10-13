import 'package:flutter/material.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: AppFonts.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
