import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'main/home_screen.dart';

enum PinState { idle, loading, success, error }

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen>
    with SingleTickerProviderStateMixin {
  static const int pinLength = 5;
  static const String correctPin = '12345';

  List<String> _digits = [];
  PinState _state = PinState.idle;
  String? _errorMessage;
  OverlayEntry? _overlayEntry;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _onDigit(String d) {
    if (_state == PinState.loading) return;
    if (_digits.length >= pinLength) return;
    setState(() {
      _state = PinState.idle;
      _errorMessage = null;
      _digits = [..._digits, d];
    });
    if (_digits.length == pinLength) _verifyPin();
  }

  void _onDelete() {
    if (_state == PinState.loading) return;
    if (_digits.isEmpty) return;
    setState(() {
      _errorMessage = null;
      _digits = _digits.sublist(0, _digits.length - 1);
    });
  }

  Future<void> _verifyPin() async {
    setState(() => _state = PinState.loading);
    await Future.delayed(const Duration(milliseconds: 800));
    final entered = _digits.join();
    if (entered == correctPin) {
      setState(() => _state = PinState.success);
      await Future.delayed(const Duration(milliseconds: 400));
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
            transitionDuration: const Duration(milliseconds: 400),
          ),
          (route) => false,
        );
      }
    } else {
      _shakeController.forward(from: 0);
      setState(() {
        _state = PinState.error;
        _errorMessage = 'Incorrect PIN, try again';
      });
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() => _digits = []);
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) setState(() => _state = PinState.idle);
    }
  }

  void _showToast(String message) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (ctx) => _Toast(
        message: message,
        onDismiss: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  Color get _dotColor {
    switch (_state) {
      case PinState.error:
        return const Color(0xFFFF536F);
      case PinState.success:
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF151515);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF151515), size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: const EdgeInsets.only(left: 16),
                ),
              ),
            ),
            const Spacer(flex: 3),
            // Title + dots with shake
            AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (ctx, child) {
                final v = _shakeController.value;
                final dx = _state == PinState.error
                    ? 12.0 * (1 - v) * (v < 0.5 ? 1 : -1)
                    : 0.0;
                return Transform.translate(
                  offset: Offset(dx, 0),
                  child: child,
                );
              },
              child: Column(
                children: [
                  Text(
                    _state == PinState.error
                        ? 'Wrong PIN'
                        : 'Enter transaction PIN',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: _state == PinState.error
                          ? const Color(0xFFFF536F)
                          : const Color(0xFF151515),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pinLength, (i) {
                      final filled = i < _digits.length;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filled ? _dotColor : Colors.transparent,
                          border: Border.all(
                            color: filled ? _dotColor : const Color(0xFFA5B1BC),
                            width: 1.5,
                          ),
                        ),
                      );
                    }),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFFFF536F),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(flex: 2),
            // Keypad or loader
            if (_state == PinState.loading)
              const SizedBox(
                height: 280,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF151515),
                    strokeWidth: 2,
                  ),
                ),
              )
            else
              _Keypad(onDigit: _onDigit, onDelete: _onDelete),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  final void Function(String) onDigit;
  final VoidCallback onDelete;

  const _Keypad({required this.onDigit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];

    return Column(
      children: [
        ...rows.map(
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((d) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _KeyButton(label: d, onTap: () => onDigit(d)),
              )).toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty slot — same width as a number button slot
            const SizedBox(width: 104),
            // 0 button — same slot width
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _KeyButton(label: '0', onTap: () => onDigit('0')),
            ),
            // Backspace — same slot width, icon centered
            SizedBox(
              width: 104,
              height: 40,
              child: GestureDetector(
                onTap: onDelete,
                child: const Center(
                  child: Icon(
                    Icons.backspace_outlined,
                    color: Color(0xFF151515),
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _KeyButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _KeyButton({required this.label, required this.onTap});

  @override
  State<_KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<_KeyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.88 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Toast extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;
  const _Toast({required this.message, required this.onDismiss});

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
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
