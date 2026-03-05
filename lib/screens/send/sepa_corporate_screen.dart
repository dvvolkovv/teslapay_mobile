import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SepaCorporateScreen extends StatefulWidget {
  const SepaCorporateScreen({super.key});

  @override
  State<SepaCorporateScreen> createState() => _SepaCorporateScreenState();
}

class _SepaCorporateScreenState extends State<SepaCorporateScreen> {
  final _companyCtrl = TextEditingController();
  final _ibanCtrl = TextEditingController();
  final _bicCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();

  bool get _canContinue =>
      _companyCtrl.text.isNotEmpty &&
      _ibanCtrl.text.isNotEmpty &&
      _amountCtrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _companyCtrl.addListener(() => setState(() {}));
    _ibanCtrl.addListener(() => setState(() {}));
    _bicCtrl.addListener(() => setState(() {}));
    _amountCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _ibanCtrl.dispose();
    _bicCtrl.dispose();
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
          'SEPA Corporate',
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
              '1/5',
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
                widthFactor: 1 / 5,
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
              controller: _companyCtrl,
              label: 'Company Name',
              hint: 'Acme GmbH',
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _ibanCtrl,
              label: 'IBAN',
              hint: 'DE89 3704 0044 0532 0130 00',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _bicCtrl,
              label: 'BIC / SWIFT',
              hint: 'DEUTDEDB',
              textCapitalization: TextCapitalization.characters,
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
