import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.label,
    this.suffix,
    this.hasError = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String? label;
  final Widget? suffix;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: hasError
            ? Border.all(color: AppColors.error, width: 2)
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: label != null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.center,
              children: [
                if (label != null) ...[
                  Text(
                    label!,
                    style: AppTextStyles.tiny(color: AppColors.secondary),
                  ),
                  const SizedBox(height: 2),
                ],
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  obscureText: obscureText,
                  cursorColor: AppColors.primary,
                  style: AppTextStyles.body(),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppTextStyles.body(color: AppColors.secondary),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          ?suffix,
        ],
      ),
    );
  }
}
