import 'package:flutter/material.dart';
import 'app_fonts.dart';
import 'validators.dart'; // 👈 Import your validators file

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final TextEditingController? confirmWithController; // 👈 for confirm password
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final int maxLines;
  final FocusNode? focusNode;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final Color? fillColor;
  final bool isPassword;
  final bool isConfirmPassword;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.focusNode,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.contentPadding =
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.fillColor,
    this.isPassword = false,
    this.isConfirmPassword = false,
    this.confirmWithController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        // ✅ Priority 1: Custom validator if provided
        if (validator != null) {
          return validator!(value);
        }

        // ✅ Password validation
        if (isPassword) {
          return Validators.password(value);
        }

        // ✅ Confirm password validation
        if (isConfirmPassword) {
          return Validators.confirmPassword(
            value,
            confirmWithController?.text,
          );
        }

        // ✅ Default: no validation
        return null;
      },
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      focusNode: focusNode,
      enabled: enabled,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: AppFonts.fontFamily),
        labelText: labelText,
        labelStyle: TextStyle(fontFamily: AppFonts.fontFamily),
        filled: true,
        fillColor: fillColor ?? Colors.grey.shade50,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: theme.primaryColor)
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon, color: theme.primaryColor),
          onPressed: () {
            // handle from parent if needed
          },
        )
            : null,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
