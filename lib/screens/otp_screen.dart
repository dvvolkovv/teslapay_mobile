import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pin_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasError = false;
  int _resendSeconds = 58;
  Timer? _timer;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasError = false;
        _errorText = '';
      });
    });
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
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

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onContinue() {
    final code = _controller.text;
    if (code.isEmpty) return;
    if (code == '12345') {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PinScreen(),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    } else {
      setState(() {
        _hasError = true;
        _errorText = 'The entered code is not valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final maskedPhone = widget.phone.replaceRange(
      0,
      widget.phone.length > 4 ? widget.phone.length - 4 : 0,
      '**** ',
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.5)),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: bottom),
            child: SafeArea(
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFFF0EFEC),
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title
                    Text(
                      'Login or Register\nto TeslaPay',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF0EFEC),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      "We've sent a sms to $maskedPhone with a five digit code. Enter the code below",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFFF0EFEC),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Code input
                    _CodeInput(
                      controller: _controller,
                      focusNode: _focusNode,
                      hasError: _hasError,
                      errorText: _errorText,
                    ),
                    const SizedBox(height: 16),
                    // Continue button
                    GestureDetector(
                      onTap: _onContinue,
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFBA08),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'CONTINUE',
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
                    const SizedBox(height: 12),
                    // Resend timer
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
                ),
              ),
            ),
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
