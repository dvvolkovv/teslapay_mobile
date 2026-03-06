import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

enum _PinChangeStep { current, newPin, confirm }

enum _PinChangeState { idle, loading, success, error }

class CardPinChangeScreen extends StatefulWidget {
  const CardPinChangeScreen({super.key});

  @override
  State<CardPinChangeScreen> createState() => _CardPinChangeScreenState();
}

class _CardPinChangeScreenState extends State<CardPinChangeScreen>
    with SingleTickerProviderStateMixin {
  static const int _pinLength = 4;
  static const String _currentPin = '1234'; // demo hardcode

  _PinChangeStep _step = _PinChangeStep.current;
  _PinChangeState _state = _PinChangeState.idle;

  List<String> _digits = [];
  String? _errorMessage;
  String _newPinValue = '';

  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  void _onDigit(String d) {
    if (_state == _PinChangeState.loading ||
        _state == _PinChangeState.success) {
      return;
    }
    if (_digits.length >= _pinLength) return;
    setState(() {
      _state = _PinChangeState.idle;
      _errorMessage = null;
      _digits = [..._digits, d];
    });
    if (_digits.length == _pinLength) _processPin();
  }

  void _onDelete() {
    if (_state == _PinChangeState.loading ||
        _state == _PinChangeState.success) {
      return;
    }
    if (_digits.isEmpty) return;
    setState(() {
      _errorMessage = null;
      _digits = _digits.sublist(0, _digits.length - 1);
    });
  }

  Future<void> _processPin() async {
    setState(() => _state = _PinChangeState.loading);
    await Future.delayed(const Duration(milliseconds: 600));

    final entered = _digits.join();

    switch (_step) {
      case _PinChangeStep.current:
        if (entered == _currentPin) {
          setState(() {
            _step = _PinChangeStep.newPin;
            _state = _PinChangeState.idle;
            _digits = [];
            _errorMessage = null;
          });
        } else {
          _shakeCtrl.forward(from: 0);
          setState(() {
            _state = _PinChangeState.error;
            _errorMessage = 'Incorrect PIN, try again';
          });
          await Future.delayed(const Duration(milliseconds: 600));
          setState(() => _digits = []);
          await Future.delayed(const Duration(milliseconds: 400));
          if (mounted) setState(() => _state = _PinChangeState.idle);
        }
        break;

      case _PinChangeStep.newPin:
        _newPinValue = entered;
        setState(() {
          _step = _PinChangeStep.confirm;
          _state = _PinChangeState.idle;
          _digits = [];
          _errorMessage = null;
        });
        break;

      case _PinChangeStep.confirm:
        if (entered == _newPinValue) {
          setState(() => _state = _PinChangeState.success);
        } else {
          _shakeCtrl.forward(from: 0);
          setState(() {
            _state = _PinChangeState.error;
            _errorMessage = 'PINs do not match, try again';
            _step = _PinChangeStep.newPin;
          });
          await Future.delayed(const Duration(milliseconds: 600));
          setState(() => _digits = []);
          await Future.delayed(const Duration(milliseconds: 400));
          if (mounted) setState(() => _state = _PinChangeState.idle);
        }
        break;
    }
  }

  String get _title {
    if (_state == _PinChangeState.success) return 'PIN Changed!';
    switch (_step) {
      case _PinChangeStep.current:
        return 'Enter current PIN';
      case _PinChangeStep.newPin:
        return 'Enter new PIN';
      case _PinChangeStep.confirm:
        return 'Confirm new PIN';
    }
  }

  Color get _dotColor {
    switch (_state) {
      case _PinChangeState.error:
        return const Color(0xFFFF536F);
      case _PinChangeState.success:
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFFFFBA08);
    }
  }

  int get _stepIndex {
    switch (_step) {
      case _PinChangeStep.current:
        return 0;
      case _PinChangeStep.newPin:
        return 1;
      case _PinChangeStep.confirm:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151515),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFF0EFEC), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Set new PIN code',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF0EFEC),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded,
                color: Color(0xFFF0EFEC), size: 22),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // Success state
            if (_state == _PinChangeState.success)
              _SuccessView(onDone: () => Navigator.of(context).pop())
            else ...[
              AnimatedBuilder(
                animation: _shakeAnim,
                builder: (ctx, child) {
                  final v = _shakeCtrl.value;
                  final dx = _state == _PinChangeState.error
                      ? 12.0 * (1 - v) * (v < 0.5 ? 1 : -1)
                      : 0.0;
                  return Transform.translate(
                      offset: Offset(dx, 0), child: child);
                },
                child: Column(
                  children: [
                    Text(
                      _title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: _state == _PinChangeState.error
                            ? const Color(0xFFFF536F)
                            : const Color(0xFFF0EFEC),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Small card preview
                    Container(
                      width: 56,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2B2B),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: _MiniMastercardLogo(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pinLength, (i) {
                        final filled = i < _digits.length;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: filled ? _dotColor : Colors.transparent,
                            border: Border.all(
                              color: filled
                                  ? _dotColor
                                  : const Color(0xFF858585),
                              width: 1.5,
                            ),
                          ),
                        );
                      }),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 10),
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
              if (_state == _PinChangeState.loading)
                const SizedBox(
                  height: 280,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFFBA08),
                      strokeWidth: 2,
                    ),
                  ),
                )
              else
                _PinKeypad(onDigit: _onDigit, onDelete: _onDelete),
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final isActive = i == currentStep;
        final isDone = i < currentStep;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isDone || isActive
                  ? const Color(0xFFFFBA08)
                  : const Color(0xFFD0D5DD),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

class _SuccessView extends StatefulWidget {
  final VoidCallback onDone;

  const _SuccessView({required this.onDone});

  @override
  State<_SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<_SuccessView>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scale,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  color: Color(0xFF4CAF50), size: 44),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your new PIN is now active',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF858585),
            ),
          ),
        ],
      ),
    );
  }
}

class _PinKeypad extends StatelessWidget {
  final void Function(String) onDigit;
  final VoidCallback onDelete;

  const _PinKeypad({required this.onDigit, required this.onDelete});

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
              children: row
                  .map((d) => Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 32),
                        child: _PinKeyBtn(
                            label: d, onTap: () => onDigit(d)),
                      ))
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 104),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _PinKeyBtn(label: '0', onTap: () => onDigit('0')),
            ),
            SizedBox(
              width: 104,
              height: 40,
              child: GestureDetector(
                onTap: onDelete,
                child: const Center(
                  child: Icon(
                    Icons.backspace_outlined,
                    color: Color(0xFFF0EFEC),
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

class _PinKeyBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _PinKeyBtn({required this.label, required this.onTap});

  @override
  State<_PinKeyBtn> createState() => _PinKeyBtnState();
}

class _PinKeyBtnState extends State<_PinKeyBtn> {
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
                color: const Color(0xFFF0EFEC),
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniMastercardLogo extends StatelessWidget {
  const _MiniMastercardLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 12,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 12, height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 12, height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFF79E1B),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
