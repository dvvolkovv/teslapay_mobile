import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teslapay_confirm_screen.dart';

class TeslapayAmountScreen extends StatefulWidget {
  final String recipientName;
  final String recipientPhone;

  const TeslapayAmountScreen({
    super.key,
    required this.recipientName,
    required this.recipientPhone,
  });

  @override
  State<TeslapayAmountScreen> createState() => _TeslapayAmountScreenState();
}

class _TeslapayAmountScreenState extends State<TeslapayAmountScreen> {
  String _amount = '';
  final _commentCtrl = TextEditingController();

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  String get _displayAmount {
    if (_amount.isEmpty) return '€ 0.00';
    final val = double.tryParse(_amount.replaceAll(',', '.')) ?? 0;
    return '€ ${val.toStringAsFixed(2)}';
  }

  void _onKey(String key) {
    setState(() {
      if (key == '<') {
        if (_amount.isNotEmpty) {
          _amount = _amount.substring(0, _amount.length - 1);
        }
      } else if (key == '.') {
        if (!_amount.contains('.')) {
          _amount = _amount.isEmpty ? '0.' : '$_amount.';
        }
      } else {
        // Limit digits after decimal
        if (_amount.contains('.')) {
          final parts = _amount.split('.');
          if (parts[1].length < 2) {
            _amount = '$_amount$key';
          }
        } else {
          _amount = '$_amount$key';
        }
      }
    });
  }

  bool get _canContinue => _amount.isNotEmpty && double.parse(_amount.replaceAll(',', '.')) > 0;

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'Amount',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              '3/3',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF858585),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Stack(
            children: [
              Container(height: 2, color: const Color(0xFFDEE5F2)),
              Container(height: 2, color: const Color(0xFFFFBA08)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Currency selector row
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEFF2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '€',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF151515),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Euro',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF151515),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '4 250 EUR',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF151515),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.unfold_more_rounded,
                          size: 20,
                          color: Color(0xFF858585),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Recipient card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xFFFFBA08),
                          child: Text(
                            _initials(widget.recipientName),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF151515),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.recipientName,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF151515),
                              ),
                            ),
                            Text(
                              widget.recipientPhone,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF858585),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Amount display
                  Text(
                    _displayAmount,
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF151515),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: € 4,250.00',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF858585),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Comment field
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _commentCtrl,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF151515),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Add comment (optional)',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFF858585),
                        ),
                      ),
                      cursorColor: const Color(0xFFFFBA08),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // CONTINUE button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: GestureDetector(
              onTap: _canContinue
                  ? () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, a, b) => TeslapayConfirmScreen(
                            recipientName: widget.recipientName,
                            recipientPhone: widget.recipientPhone,
                            amount: _displayAmount,
                          ),
                          transitionsBuilder: (_, anim, b, child) =>
                              SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                                parent: anim, curve: Curves.easeOut)),
                            child: child,
                          ),
                          transitionDuration:
                              const Duration(milliseconds: 300),
                        ),
                      );
                    }
                  : null,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: _canContinue
                      ? const Color(0xFFFFBA08)
                      : const Color(0xFFFFBA08).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'CONTINUE',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _canContinue
                          ? const Color(0xFF151515)
                          : const Color(0xFFD68803),
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Numeric keyboard
          _NumericKeyboard(onKey: _onKey),
        ],
      ),
    );
  }
}

class _NumericKeyboard extends StatelessWidget {
  final void Function(String) onKey;

  const _NumericKeyboard({required this.onKey});

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', '<'],
    ];

    return Container(
      color: const Color(0xFFEBEFF2),
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 24),
      child: Column(
        children: keys.map((row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: row.map((k) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: GestureDetector(
                      onTap: () => onKey(k),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: k == '<'
                              ? const Icon(
                                  Icons.backspace_outlined,
                                  color: Color(0xFF151515),
                                  size: 22,
                                )
                              : Text(
                                  k,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF151515),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
