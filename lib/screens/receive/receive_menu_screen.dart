import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'banking_card_receive_screen.dart';
import 'qr_receive_screen.dart';
import 'sepa_receive_screen.dart';
import 'swift_receive_screen.dart';

class ReceiveMenuScreen extends StatelessWidget {
  const ReceiveMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'Receive',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _ReceiveOptionCard(
            icon: Icons.credit_card_rounded,
            title: 'Banking Card',
            subtitle: 'Receive to your card number',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BankingCardReceiveScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _ReceiveOptionCard(
            icon: Icons.qr_code_rounded,
            title: 'QR Code',
            subtitle: 'Show QR for payment',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const QrReceiveScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _ReceiveOptionCard(
            icon: Icons.account_balance_rounded,
            title: 'SEPA',
            subtitle: 'Receive via SEPA transfer',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SepaReceiveScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _ReceiveOptionCard(
            icon: Icons.swap_horiz_rounded,
            title: 'SWIFT',
            subtitle: 'Receive via SWIFT transfer',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SwiftReceiveScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiveOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ReceiveOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F5F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF151515), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF151515),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF858585),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFA5B1BC),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
