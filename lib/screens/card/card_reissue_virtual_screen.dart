import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_reissue_success_screen.dart';

class CardReissueVirtualScreen extends StatefulWidget {
  const CardReissueVirtualScreen({super.key});

  @override
  State<CardReissueVirtualScreen> createState() =>
      _CardReissueVirtualScreenState();
}

class _CardReissueVirtualScreenState extends State<CardReissueVirtualScreen> {
  String _selectedReason = 'card_lost';

  final _reasons = const [
    {'value': 'card_damaged', 'label': 'Card damaged'},
    {'value': 'card_lost', 'label': 'Card lost/stolen'},
    {'value': 'other', 'label': 'Other'},
  ];

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
          'Reissue Virtual Card',
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
            // Current card info tile
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF151515),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2B2B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Icon(Icons.credit_card_rounded,
                          color: Color(0xFF858585), size: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Black Plastic',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF0EFEC),
                          ),
                        ),
                        Text(
                          '•••• •••• •••• 1234',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF858585),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Active',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF4CAF50),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Reason for reissue',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
            const SizedBox(height: 12),
            // Reason radio buttons
            Container(
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
                children: _reasons.asMap().entries.map((e) {
                  final i = e.key;
                  final reason = e.value;
                  final isLast = i == _reasons.length - 1;
                  final isSelected = _selectedReason == reason['value'];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () =>
                            setState(() => _selectedReason = reason['value']!),
                        borderRadius: isLast
                            ? const BorderRadius.vertical(
                                bottom: Radius.circular(16))
                            : BorderRadius.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFFFBA08)
                                        : const Color(0xFFA5B1BC),
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFFFBA08),
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                reason['label']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: const Color(0xFF151515),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast)
                        const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xFFF2F5F7)),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Warning banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFF536F).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFF536F).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Color(0xFFFF536F), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Your current card will be deactivated immediately after confirmation.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFFFF536F),
                        height: 1.4,
                      ),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CardReissueSuccessScreen()),
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
                  'CONFIRM',
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
