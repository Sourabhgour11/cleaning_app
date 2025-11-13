import 'package:flutter/material.dart';
import 'app_colours.dart';
import 'app_fonts.dart';
import 'app_style.dart';
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
  final VoidCallback? onSuffixTap;

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
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: AppStyle.widthPercent(context, 90),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColours.grey.withOpacity(0.2),
          width: 1.5,
        ),

      ),
      child: TextFormField(
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
          hintStyle: TextStyle(fontFamily: AppFonts.fontFamily,color: AppColours.grey),
          labelText: labelText,
          labelStyle: TextStyle(fontFamily: AppFonts.fontFamily),
          filled: true,
          fillColor: fillColor ?? Colors.white,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColours.grey,size: 18,)
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(suffixIcon, color: AppColours.grey,size: 18,),
            onPressed:onSuffixTap
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
      ),
    );
  }
}
