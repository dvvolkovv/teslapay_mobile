import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class BankingCardReceiveScreen extends StatelessWidget {
  const BankingCardReceiveScreen({super.key});

  static const String _cardNumber = '4521 •••• •••• 1234';
  static const String _cardNumberRaw = '4521000000001234';

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied!',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF151515),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _shareDetails(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing card details...',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF151515),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'Receive to Card',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card display
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F2A32), Color(0xFF2C3E50)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFBA08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Mastercard Virtual',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF151515),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEB001B).withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned(
                            left: 16,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF79E1B).withValues(alpha: 0.85),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    _cardNumber,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF0EFEC),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your card number',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFFA5B1BC),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card info card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(
                    label: 'Card Number',
                    value: _cardNumber,
                    onCopy: () =>
                        _copyToClipboard(context, _cardNumberRaw, 'Card number'),
                  ),
                  const Divider(color: Color(0xFFF2F5F7), height: 1),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'Card Type',
                    value: 'Mastercard Virtual',
                    showCopy: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Instruction text
            Text(
              'Share this number to receive payments',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF858585),
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons row
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.copy_rounded,
                    label: 'Copy',
                    onTap: () =>
                        _copyToClipboard(context, _cardNumberRaw, 'Card number'),
                    outlined: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    onTap: () => _shareDetails(context),
                    outlined: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onCopy;
  final bool showCopy;

  const _InfoRow({
    required this.label,
    required this.value,
    this.onCopy,
    this.showCopy = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF858585),
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF151515),
                ),
              ),
              if (showCopy && onCopy != null) ...[
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy_rounded,
                      size: 16, color: Color(0xFF858585)),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool outlined;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.outlined,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: outlined ? Colors.white : const Color(0xFFFFBA08),
          borderRadius: BorderRadius.circular(50),
          border: outlined
              ? Border.all(color: const Color(0xFFA5B1BC))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 18,
                color: outlined
                    ? const Color(0xFF151515)
                    : const Color(0xFF151515)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
