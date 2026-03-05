import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeslapayConfirmScreen extends StatefulWidget {
  final String recipientName;
  final String recipientPhone;
  final String amount;

  const TeslapayConfirmScreen({
    super.key,
    required this.recipientName,
    required this.recipientPhone,
    required this.amount,
  });

  @override
  State<TeslapayConfirmScreen> createState() => _TeslapayConfirmScreenState();
}

class _TeslapayConfirmScreenState extends State<TeslapayConfirmScreen>
    with SingleTickerProviderStateMixin {
  bool _sent = false;
  late AnimationController _checkController;
  late Animation<double> _checkScale;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _checkScale = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Future<void> _onConfirm() async {
    setState(() => _sent = true);
    _checkController.forward();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // Pop back to send menu
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
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
          'Confirm',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
      ),
      body: _sent ? _buildSuccess() : _buildConfirm(),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _checkScale,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Transfer Sent!',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF151515),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.amount} sent to ${widget.recipientName}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF858585),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Recipient header
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
          const SizedBox(height: 16),
          // Summary card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _SummaryRow(label: 'Amount', value: widget.amount),
                const Divider(height: 1, color: Color(0xFFDEE5F2), indent: 16, endIndent: 16),
                _SummaryRow(label: 'Fee', value: '€ 0.00'),
                const Divider(height: 1, color: Color(0xFFDEE5F2), indent: 16, endIndent: 16),
                _SummaryRow(
                  label: 'Total',
                  value: widget.amount,
                  isTotal: true,
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _onConfirm,
            child: Container(
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFFFBA08),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'CONFIRM & SEND',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF151515),
                    letterSpacing: 0.32,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

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
              fontSize: 15,
              color: const Color(0xFF858585),
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: const Color(0xFF151515),
            ),
          ),
        ],
      ),
    );
  }
}
