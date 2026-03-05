import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SepaPersonalScreen extends StatefulWidget {
  const SepaPersonalScreen({super.key});

  @override
  State<SepaPersonalScreen> createState() => _SepaPersonalScreenState();
}

class _SepaPersonalScreenState extends State<SepaPersonalScreen> {
  final _ibanCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();

  bool get _canContinue =>
      _ibanCtrl.text.isNotEmpty &&
      _nameCtrl.text.isNotEmpty &&
      _amountCtrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _ibanCtrl.addListener(() => setState(() {}));
    _nameCtrl.addListener(() => setState(() {}));
    _amountCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ibanCtrl.dispose();
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    _referenceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'SEPA Transfer',
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
              '1/6',
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
              FractionallySizedBox(
                widthFactor: 1 / 6,
                child: Container(height: 2, color: const Color(0xFFFFBA08)),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildInput(
              controller: _ibanCtrl,
              label: 'IBAN',
              hint: 'DE89 3704 0044 0532 0130 00',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _nameCtrl,
              label: 'Recipient Name',
              hint: 'John Doe',
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _amountCtrl,
              label: 'Amount',
              hint: '0.00',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              prefix: '€ ',
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _referenceCtrl,
              label: 'Reference',
              hint: 'Optional reference',
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: _canContinue
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Proceeding to confirmation...',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          backgroundColor: const Color(0xFF151515),
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
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? prefix,
  }) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.text.isNotEmpty)
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF858585),
                letterSpacing: 0.25,
              ),
            ),
          Row(
            children: [
              if (prefix != null && controller.text.isNotEmpty)
                Text(
                  prefix,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textCapitalization: textCapitalization,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintText: controller.text.isEmpty ? label : hint,
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
        ],
      ),
    );
  }
}
