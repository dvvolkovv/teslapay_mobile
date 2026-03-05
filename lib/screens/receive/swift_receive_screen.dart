import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SwiftReceiveScreen extends StatelessWidget {
  const SwiftReceiveScreen({super.key});

  static const _accountNumber = 'DE89370400440532013000';
  static const _swiftBic = 'COBADEFFXXX';
  static const _bankName = 'Commerzbank AG';
  static const _bankAddress = 'Kaiserplatz, 60311 Frankfurt am Main';
  static const _country = 'Germany';
  static const _holderName = 'Alexander Smith';

  void _copy(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));
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
          'Sharing SWIFT details...',
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
          'Receive via SWIFT',
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
            // SWIFT details card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _CopyableRow(
                    label: 'Account Number',
                    value: _accountNumber,
                    onCopy: () => _copy(context, _accountNumber),
                  ),
                  _Divider(),
                  _CopyableRow(
                    label: 'SWIFT / BIC',
                    value: _swiftBic,
                    onCopy: () => _copy(context, _swiftBic),
                  ),
                  _Divider(),
                  _CopyableRow(
                    label: 'Bank Name',
                    value: _bankName,
                    showCopy: false,
                  ),
                  _Divider(),
                  _CopyableRow(
                    label: 'Bank Address',
                    value: _bankAddress,
                    showCopy: false,
                  ),
                  _Divider(),
                  _CopyableRow(
                    label: 'Country',
                    value: _country,
                    showCopy: false,
                  ),
                  _Divider(),
                  _CopyableRow(
                    label: 'Account Holder',
                    value: _holderName,
                    showCopy: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Fee note
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFBA08)),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: Color(0xFFFFBA08), size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'SWIFT transfers may incur fees charged by intermediary banks. '
                      'Transfers typically take 2–5 business days internationally.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF858585),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Share button
            GestureDetector(
              onTap: () => _shareDetails(context),
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBA08),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share_rounded,
                        color: Color(0xFF151515), size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Share details',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF151515),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(color: Color(0xFFF2F5F7), height: 1, thickness: 1);
  }
}

class _CopyableRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onCopy;
  final bool showCopy;

  const _CopyableRow({
    required this.label,
    required this.value,
    this.onCopy,
    this.showCopy = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
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
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF151515),
                    ),
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
          ),
        ],
      ),
    );
  }
}
