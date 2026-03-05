import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared text input field used across profile edit screens.
class ProfileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextInputType keyboardType;

  const ProfileInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF151515),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF858585),
                    letterSpacing: 0.25,
                  ),
                ),
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFFA5B1BC),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              cursorColor: const Color(0xFFFFBA08),
            ),
          ),
          ?suffix,
        ],
      ),
    );
  }
}

/// Shared yellow save button used across profile edit screens.
class ProfileSaveButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const ProfileSaveButton({
    super.key,
    required this.onTap,
    this.label = 'SAVE',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFFFFBA08),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF151515),
              letterSpacing: 0.32,
            ),
          ),
        ),
      ),
    );
  }
}

/// Shared dark toast overlay used across profile screens.
class ProfileToast extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const ProfileToast({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  State<ProfileToast> createState() => _ProfileToastState();
}

class _ProfileToastState extends State<ProfileToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 3), _dismiss);
  }

  void _dismiss() async {
    if (!mounted) return;
    await _ctrl.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top + 44;
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Center(
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 12, 16, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2B2B),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        widget.message,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFFF0EFEC),
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFF444444),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          size: 14, color: Color(0xFFF0EFEC)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
