import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle heading2({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle heading3({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle body({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyMedium({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle small({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle tiny({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle button({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.32,
        color: color,
      );

  static TextStyle keypad({Color color = AppColors.darkText}) =>
      GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      );
}
