import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_widgets.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final _newEmailCtrl = TextEditingController();
  final _confirmEmailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _newEmailCtrl.dispose();
    _confirmEmailCtrl.dispose();
    _passwordCtrl.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _save() {
    if (_newEmailCtrl.text.isEmpty ||
        _confirmEmailCtrl.text.isEmpty ||
        _passwordCtrl.text.isEmpty) {
      return;
    }
    if (_newEmailCtrl.text != _confirmEmailCtrl.text) {
      _showToast('Emails do not match');
      return;
    }
    _showToast('Verification email sent');
  }

  void _showToast(String message) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (ctx) => ProfileToast(
        message: message,
        onDismiss: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
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
        title: Text(
          'Change Email',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Email',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // Current email (read-only)
            Container(
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFEBEFF2),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Current email',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF858585),
                      letterSpacing: 0.25,
                    ),
                  ),
                  Text(
                    'alex@example.com',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFFA5B1BC),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            ProfileInputField(
              controller: _newEmailCtrl,
              label: 'New email',
              hint: 'Enter new email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            ProfileInputField(
              controller: _confirmEmailCtrl,
              label: 'Confirm email',
              hint: 'Confirm new email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password with eye toggle
            Container(
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
                      controller: _passwordCtrl,
                      obscureText: _obscurePassword,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF151515),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF858585),
                            letterSpacing: 0.25,
                          ),
                        ),
                        hintText: 'Enter password',
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
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFFA5B1BC),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            ProfileSaveButton(onTap: _save),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
