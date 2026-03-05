import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teslapay_send_screen.dart';
import 'mastercard_send_screen.dart';
import 'sepa_personal_screen.dart';
import 'sepa_corporate_screen.dart';
import 'swift_personal_screen.dart';
import 'swift_corporate_screen.dart';
import 'qr_scan_screen.dart';

class SendMenuScreen extends StatelessWidget {
  const SendMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'Send',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Top row: TeslaPay + Scan QR (tall + highlight)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _SendOptionCard(
                      title: 'TeslaPay\nclient',
                      backgroundColor: const Color(0xFFEAE6E1),
                      icon: Icons.person_outline_rounded,
                      height: 170,
                      onTap: () => _push(context, const TeslapaySendScreen()),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Column(
                      children: [
                        _SendOptionCardHighlight(
                          title: 'Scan\nQR-code',
                          backgroundColor: const Color(0xFF2937BE),
                          textColor: const Color(0xFFF2F5F7),
                          icon: Icons.qr_code_scanner_rounded,
                          onTap: () => _push(context, const QrScanScreen()),
                        ),
                        const SizedBox(height: 7),
                        _SendOptionCard(
                          title: 'Banking\ncard',
                          backgroundColor: const Color(0xFFEAE6E1),
                          icon: Icons.credit_card_rounded,
                          height: 95,
                          onTap: () =>
                              _push(context, const MastercardSendScreen()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              // Second row: SWIFT + SEPA transfer
              Row(
                children: [
                  Expanded(
                    child: _SendOptionCard(
                      title: 'SWIFT\ntransfer',
                      backgroundColor: const Color(0xFFEAE6E1),
                      icon: Icons.public_rounded,
                      height: 170,
                      onTap: () =>
                          _push(context, const SwiftPersonalScreen()),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: _SendOptionCard(
                      title: 'SEPA\ntransfer (EUR)',
                      backgroundColor: const Color(0xFFEAE6E1),
                      icon: Icons.account_balance_rounded,
                      height: 170,
                      onTap: () =>
                          _push(context, const SepaPersonalScreen()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              // Third row: SEPA Corporate + SWIFT Corporate
              Row(
                children: [
                  Expanded(
                    child: _SendOptionCard(
                      title: 'SEPA\nCorporate',
                      backgroundColor: const Color(0xFFEAE6E1),
                      icon: Icons.business_rounded,
                      height: 120,
                      onTap: () =>
                          _push(context, const SepaCorporateScreen()),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: _SendOptionCard(
                      title: 'SWIFT\nCorporate',
                      backgroundColor: const Color(0xFFEAE6E1),
                      icon: Icons.language_rounded,
                      height: 120,
                      onTap: () =>
                          _push(context, const SwiftCorporateScreen()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, a, b) => screen,
        transitionsBuilder: (_, anim, b, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class _SendOptionCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onTap;
  final double height;

  const _SendOptionCard({
    required this.title,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
    this.height = 170,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF151515),
                  height: 1.2,
                ),
              ),
            ),
            Positioned(
              bottom: -8,
              right: -8,
              child: Icon(
                icon,
                size: 90,
                color: const Color(0xFF151515).withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendOptionCardHighlight extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final VoidCallback onTap;

  const _SendOptionCardHighlight({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
                height: 1.2,
              ),
            ),
            Icon(icon, size: 32, color: textColor),
          ],
        ),
      ),
    );
  }
}
