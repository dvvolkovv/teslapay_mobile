import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_password_success_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  bool get _hasMinLength => _newCtrl.text.length >= 8;
  bool get _hasUppercase => _newCtrl.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber => _newCtrl.text.contains(RegExp(r'[0-9]'));

  @override
  void initState() {
    super.initState();
    _newCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_currentCtrl.text.isEmpty ||
        _newCtrl.text.isEmpty ||
        _confirmCtrl.text.isEmpty) {
      return;
    }
    if (!_hasMinLength || !_hasUppercase || !_hasNumber) {
      return;
    }
    if (_newCtrl.text != _confirmCtrl.text) {
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (ctx, a1, a2) => const ChangePasswordSuccessScreen(),
        transitionsBuilder: (ctx, anim, a2, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF151515), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change password',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            _PasswordInput(
              controller: _currentCtrl,
              label: 'Current password',
              hint: 'Enter current password',
              obscure: _obscureCurrent,
              onToggle: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            const SizedBox(height: 16),
            _PasswordInput(
              controller: _newCtrl,
              label: 'New password',
              hint: 'Enter new password',
              obscure: _obscureNew,
              onToggle: () => setState(() => _obscureNew = !_obscureNew),
            ),
            const SizedBox(height: 16),
            _PasswordInput(
              controller: _confirmCtrl,
              label: 'Confirm new password',
              hint: 'Confirm new password',
              obscure: _obscureConfirm,
              onToggle: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            const SizedBox(height: 20),

            // Requirements checklist
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password requirements',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF151515),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _RequirementRow(
                      met: _hasMinLength, text: 'At least 8 characters'),
                  const SizedBox(height: 6),
                  _RequirementRow(
                      met: _hasUppercase, text: 'One uppercase letter'),
                  const SizedBox(height: 6),
                  _RequirementRow(met: _hasNumber, text: 'One number'),
                ],
              ),
            ),

            const Spacer(),
            GestureDetector(
              onTap: _save,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBA08),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF151515),
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordInput({
    required this.controller,
    required this.label,
    required this.hint,
    required this.obscure,
    required this.onToggle,
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
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: const Color(0xFFA5B1BC),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final bool met;
  final String text;

  const _RequirementRow({required this.met, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
          size: 16,
          color: met ? const Color(0xFF099A29) : const Color(0xFFA5B1BC),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: met ? const Color(0xFF099A29) : const Color(0xFF858585),
          ),
        ),
      ],
    );
  }
}
