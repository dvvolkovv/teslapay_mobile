import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class CardFreezeScreen extends StatefulWidget {
  const CardFreezeScreen({super.key});

  @override
  State<CardFreezeScreen> createState() => _CardFreezeScreenState();
}

class _CardFreezeScreenState extends State<CardFreezeScreen> {
  bool _isFrozen = false;

  void _toggleFreeze() {
    if (_isFrozen) {
      // Unfreeze directly
      setState(() => _isFrozen = false);
    } else {
      // Show PIN confirmation bottom sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _FreezePinSheet(
          onConfirmed: () {
            Navigator.pop(context);
            setState(() => _isFrozen = true);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF151515), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Freeze Card',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Card preview — grayed if frozen
            AnimatedOpacity(
              opacity: _isFrozen ? 0.4 : 1.0,
              duration: const Duration(milliseconds: 400),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Black Plastic',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFFF0EFEC),
                          ),
                        ),
                        if (_isFrozen)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.ac_unit_rounded,
                                    color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  'Frozen',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Text(
                      '•••• •••• •••• 1234',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF0EFEC),
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'JOHN DOE',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF858585),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Status text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _isFrozen ? 'Your card is frozen' : 'Your card is active',
                key: ValueKey(_isFrozen),
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: _isFrozen
                      ? const Color(0xFF151515)
                      : const Color(0xFF151515),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Info text
            Text(
              _isFrozen
                  ? 'Your card has been frozen. No payments or withdrawals can be made while the card is frozen. You can unfreeze it anytime.'
                  : 'Freezing your card will temporarily block all payments, withdrawals, and online transactions. You can unfreeze it at any time.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF858585),
                height: 1.5,
              ),
            ),
            const Spacer(),
            // Freeze / Unfreeze button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _toggleFreeze,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFrozen
                      ? const Color(0xFFFFBA08)
                      : const Color(0xFF151515),
                  foregroundColor: _isFrozen
                      ? const Color(0xFF151515)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isFrozen
                          ? Icons.wb_sunny_outlined
                          : Icons.ac_unit_rounded,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isFrozen ? 'Unfreeze Card' : 'Freeze Card',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── PIN Bottom Sheet ──────────────────────────────────────────────────────────

class _FreezePinSheet extends StatefulWidget {
  final VoidCallback onConfirmed;

  const _FreezePinSheet({required this.onConfirmed});

  @override
  State<_FreezePinSheet> createState() => _FreezePinSheetState();
}

class _FreezePinSheetState extends State<_FreezePinSheet>
    with SingleTickerProviderStateMixin {
  static const int _pinLength = 4;
  static const String _demoPin = '1234';

  List<String> _digits = [];
  bool _error = false;
  bool _loading = false;

  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
    if (_loading || _digits.length >= _pinLength) return;
    setState(() {
      _error = false;
      _digits = [..._digits, d];
    });
    if (_digits.length == _pinLength) _verify();
  }

  void _onDelete() {
    if (_loading || _digits.isEmpty) return;
    setState(() {
      _error = false;
      _digits = _digits.sublist(0, _digits.length - 1);
    });
  }

  Future<void> _verify() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (_digits.join() == _demoPin) {
      widget.onConfirmed();
    } else {
      _shakeCtrl.forward(from: 0);
      setState(() {
        _error = true;
        _loading = false;
        _digits = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Confirm with PIN',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0EFEC),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your 4-digit PIN to freeze the card',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF858585),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Pin dots
          AnimatedBuilder(
            animation: _shakeAnim,
            builder: (ctx, child) {
              final v = _shakeCtrl.value;
              final dx = _error ? 10.0 * (1 - v) * (v < 0.5 ? 1 : -1) : 0.0;
              return Transform.translate(offset: Offset(dx, 0), child: child);
            },
            child: Row(
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
                    color: _error
                        ? const Color(0xFFFF536F)
                        : (filled
                            ? const Color(0xFFFFBA08)
                            : Colors.transparent),
                    border: Border.all(
                      color: _error
                          ? const Color(0xFFFF536F)
                          : (filled
                              ? const Color(0xFFFFBA08)
                              : const Color(0xFF858585)),
                      width: 1.5,
                    ),
                  ),
                );
              }),
            ),
          ),
          if (_error) ...[
            const SizedBox(height: 8),
            Text(
              'Incorrect PIN, try again',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: const Color(0xFFFF536F)),
            ),
          ],
          const SizedBox(height: 24),
          if (_loading)
            const SizedBox(
              height: 220,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFBA08),
                  strokeWidth: 2,
                ),
              ),
            )
          else
            _SheetKeypad(onDigit: _onDigit, onDelete: _onDelete),
        ],
      ),
    );
  }
}

class _SheetKeypad extends StatelessWidget {
  final void Function(String) onDigit;
  final VoidCallback onDelete;

  const _SheetKeypad({required this.onDigit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];
    return Column(
      children: [
        ...rows.map((row) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((d) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: _SheetKeyBtn(label: d, onTap: () => onDigit(d)),
                    )).toList(),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 96),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: _SheetKeyBtn(label: '0', onTap: () => onDigit('0')),
            ),
            SizedBox(
              width: 96,
              height: 44,
              child: GestureDetector(
                onTap: onDelete,
                child: const Center(
                  child: Icon(Icons.backspace_outlined,
                      color: Color(0xFFF0EFEC), size: 22),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SheetKeyBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _SheetKeyBtn({required this.label, required this.onTap});

  @override
  State<_SheetKeyBtn> createState() => _SheetKeyBtnState();
}

class _SheetKeyBtnState extends State<_SheetKeyBtn> {
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
          height: 44,
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: 26,
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
