import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/countries.dart';
import 'recovery_success_screen.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  int _step = 1; // 1: phone, 2: otp, 3: new password

  // Step 1
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  Country _selectedCountry = kCountries[0];

  // Step 2
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();
  bool _otpHasError = false;
  String _otpErrorText = '';
  int _resendSeconds = 58;
  Timer? _timer;

  // Step 3
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() {
      setState(() {
        _otpHasError = false;
        _otpErrorText = '';
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _otpController.dispose();
    _otpFocusNode.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _resendSeconds = 58);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          t.cancel();
        }
      });
    });
  }

  void _onSendCode() {
    if (_phoneController.text.isEmpty) return;
    setState(() => _step = 2);
    _startTimer();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _otpFocusNode.requestFocus());
  }

  void _onVerify() {
    final code = _otpController.text;
    if (code.isEmpty) return;
    if (code == '12345') {
      setState(() => _step = 3);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _newPasswordFocusNode.requestFocus());
    } else {
      setState(() {
        _otpHasError = true;
        _otpErrorText = 'The entered code is not valid';
      });
    }
  }

  void _onSave() {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;
    if (newPass.isEmpty || confirmPass.isEmpty) return;
    if (!_hasMinLength(newPass) || !_hasUppercase(newPass) || !_hasNumber(newPass)) return;
    if (newPass != confirmPass) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const RecoverySuccessScreen(),
        transitionsBuilder: (_, anim, _, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Future<void> _openCountryPicker() async {
    _phoneFocusNode.unfocus();
    final result = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPickerSheet(selected: _selectedCountry),
    );
    if (result != null) {
      setState(() => _selectedCountry = result);
    }
    if (mounted) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _phoneFocusNode.requestFocus());
    }
  }

  bool _hasMinLength(String p) => p.length >= 8;
  bool _hasUppercase(String p) => p.contains(RegExp(r'[A-Z]'));
  bool _hasNumber(String p) => p.contains(RegExp(r'[0-9]'));

  String get _maskedPhone {
    final full = '${_selectedCountry.code} ${_phoneController.text}';
    if (full.length <= 4) return full;
    final last4 = full.substring(full.length - 4);
    return '**** $last4';
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.5)),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () {
                          if (_step > 1) {
                            setState(() {
                              _step--;
                              if (_step == 1) {
                                _timer?.cancel();
                                _otpController.clear();
                                _otpHasError = false;
                                _otpErrorText = '';
                              }
                            });
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFFF0EFEC),
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (_step == 1) _buildStep1(),
                      if (_step == 2) _buildStep2(),
                      if (_step == 3) _buildStep3(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Password',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF0EFEC),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your phone number to receive a verification code',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xFFF0EFEC),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),
        _PhoneInput(
          controller: _phoneController,
          focusNode: _phoneFocusNode,
          country: _selectedCountry,
          onCountryTap: _openCountryPicker,
        ),
        const SizedBox(height: 16),
        _ActionButton(
          label: 'SEND CODE',
          enabled: true,
          onTap: _onSendCode,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Code',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF0EFEC),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a code to $_maskedPhone',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xFFF0EFEC),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),
        _CodeInput(
          controller: _otpController,
          focusNode: _otpFocusNode,
          hasError: _otpHasError,
          errorText: _otpErrorText,
        ),
        const SizedBox(height: 16),
        _ActionButton(
          label: 'VERIFY',
          enabled: true,
          onTap: _onVerify,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: _resendSeconds > 0
              ? Text(
                  'Resend code in 0:${_resendSeconds.toString().padLeft(2, '0')}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFFF0EFEC),
                  ),
                )
              : GestureDetector(
                  onTap: _startTimer,
                  child: Text(
                    'Resend code',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFFFFBA08),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFFFBA08),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;
    final allFilled = newPass.isNotEmpty && confirmPass.isNotEmpty;
    final passwordsMatch = newPass == confirmPass;
    final meetsRequirements =
        _hasMinLength(newPass) && _hasUppercase(newPass) && _hasNumber(newPass);
    final canSave = allFilled && passwordsMatch && meetsRequirements;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Password',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF0EFEC),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),
        // New password
        _PasswordField(
          controller: _newPasswordController,
          focusNode: _newPasswordFocusNode,
          hintText: 'New password',
          obscureText: _obscureNew,
          onToggleObscure: () =>
              setState(() => _obscureNew = !_obscureNew),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        // Confirm password
        _PasswordField(
          controller: _confirmPasswordController,
          focusNode: _confirmPasswordFocusNode,
          hintText: 'Confirm password',
          obscureText: _obscureConfirm,
          onToggleObscure: () =>
              setState(() => _obscureConfirm = !_obscureConfirm),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 20),
        // Password requirements checklist
        _RequirementRow(
          met: _hasMinLength(newPass),
          label: 'At least 8 characters',
        ),
        const SizedBox(height: 6),
        _RequirementRow(
          met: _hasUppercase(newPass),
          label: 'At least one uppercase letter',
        ),
        const SizedBox(height: 6),
        _RequirementRow(
          met: _hasNumber(newPass),
          label: 'At least one number',
        ),
        if (allFilled && !passwordsMatch) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Passwords do not match',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFFFF536F),
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
        _ActionButton(
          label: 'SAVE',
          enabled: canSave,
          onTap: _onSave,
        ),
      ],
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final bool met;
  final String label;

  const _RequirementRow({required this.met, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
          size: 16,
          color: met ? const Color(0xFFFFBA08) : const Color(0xFF858585),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: met ? const Color(0xFFF0EFEC) : const Color(0xFF858585),
          ),
        ),
      ],
    );
  }
}

class _PhoneInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Country country;
  final VoidCallback onCountryTap;

  const _PhoneInput({
    required this.controller,
    required this.focusNode,
    required this.country,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFEBEFF2),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: onCountryTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(country.flag, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 2),
                const Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Color(0xFF151515)),
                const SizedBox(width: 6),
                Text(
                  country.code,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                    width: 1, height: 20, color: const Color(0xFFA5B1BC)),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF151515),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone number',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF858585),
                ),
                isCollapsed: true,
              ),
              cursorColor: const Color(0xFFFFBA08),
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleObscure;
  final ValueChanged<String>? onChanged;

  const _PasswordField({
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.obscureText,
    required this.onToggleObscure,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFEBEFF2),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              onChanged: onChanged,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF151515),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF858585),
                ),
                isCollapsed: true,
              ),
              cursorColor: const Color(0xFFFFBA08),
            ),
          ),
          GestureDetector(
            onTap: onToggleObscure,
            child: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xFF858585),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final String errorText;

  const _CodeInput({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFEBEFF2),
            borderRadius: BorderRadius.circular(24),
            border: hasError
                ? Border.all(color: const Color(0xFFFF536F), width: 2)
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Code',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF858585),
                  letterSpacing: 0.25,
                ),
              ),
              TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF151515),
                  letterSpacing: 4,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                ),
                cursorColor: const Color(0xFFFFBA08),
                obscureText: true,
                obscuringCharacter: '•',
              ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              errorText,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFFFF536F),
                letterSpacing: 0.25,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
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
              color: enabled
                  ? const Color(0xFF151515)
                  : const Color(0xFFD68803),
              letterSpacing: 0.32,
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  final Country selected;
  const _CountryPickerSheet({required this.selected});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<Country> _filtered = kCountries;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = q.isEmpty
            ? kCountries
            : kCountries
                .where((c) =>
                    c.name.toLowerCase().contains(q) || c.code.contains(q))
                .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFFF2F5F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFA5B1BC),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select country',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF151515),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFFA5B1BC), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFF151515)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14, color: const Color(0xFFA5B1BC)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final c = _filtered[i];
                final isSelected = c.name == widget.selected.name;
                return ListTile(
                  onTap: () => Navigator.of(context).pop(c),
                  leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
                  title: Text(
                    c.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF151515),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    c.code,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: isSelected
                          ? const Color(0xFFFFBA08)
                          : const Color(0xFF858585),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
