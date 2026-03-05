import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_reissue_success_screen.dart';

class CardReissueConfirmScreen extends StatelessWidget {
  final String country;
  final String city;
  final String street;
  final String postalCode;
  final String apartment;

  const CardReissueConfirmScreen({
    super.key,
    required this.country,
    required this.city,
    required this.street,
    required this.postalCode,
    this.apartment = '',
  });

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
          'Confirm Order',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Order Summary',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF858585),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            // Summary card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF39424D).withValues(alpha: 0.06),
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _SummaryRow(
                    label: 'Card type',
                    value: 'Physical Mastercard',
                  ),
                  const Divider(
                      height: 1, indent: 16, endIndent: 16,
                      color: Color(0xFFF2F5F7)),
                  _SummaryRow(
                    label: 'Current card',
                    value: '•••• 1234',
                  ),
                  const Divider(
                      height: 1, indent: 16, endIndent: 16,
                      color: Color(0xFFF2F5F7)),
                  _SummaryRow(
                    label: 'Delivery',
                    value: '5–10 business days',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Delivery Address',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF858585),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF39424D).withValues(alpha: 0.06),
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Color(0xFF858585), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          [
                            street,
                            if (apartment.isNotEmpty) apartment,
                            city,
                            postalCode,
                            country,
                          ].join(', '),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF151515),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Fee card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFBA08).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFFBA08).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Card issuance fee',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF151515),
                    ),
                  ),
                  Text(
                    '€ 9.99',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF151515),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CardReissueSuccessScreen()),
                    (route) => route.isFirst,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFBA08),
                  foregroundColor: const Color(0xFF151515),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'CONFIRM ORDER',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF858585),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF151515),
            ),
          ),
        ],
      ),
    );
  }
}
