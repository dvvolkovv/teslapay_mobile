import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_reissue_confirm_screen.dart';

class CardReissuePhysicalScreen extends StatefulWidget {
  const CardReissuePhysicalScreen({super.key});

  @override
  State<CardReissuePhysicalScreen> createState() =>
      _CardReissuePhysicalScreenState();
}

class _CardReissuePhysicalScreenState
    extends State<CardReissuePhysicalScreen> {
  final _formKey = GlobalKey<FormState>();
  String _country = 'Russia';
  final _cityCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  final _aptCtrl = TextEditingController();

  final _countries = [
    'Russia',
    'Germany',
    'Austria',
    'France',
    'United Kingdom',
    'United States',
    'Other',
  ];

  @override
  void dispose() {
    _cityCtrl.dispose();
    _streetCtrl.dispose();
    _postalCtrl.dispose();
    _aptCtrl.dispose();
    super.dispose();
  }

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
          'Reissue Physical Card',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Delivery info banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBA08).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFBA08).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping_outlined,
                        color: Color(0xFFFFBA08), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Estimated delivery: 5–10 business days',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF151515),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Delivery Address',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF151515),
                ),
              ),
              const SizedBox(height: 12),
              // Country dropdown
              _FieldLabel('Country'),
              const SizedBox(height: 6),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEFF2),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _country,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF858585)),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF151515),
                    ),
                    items: _countries.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (v) => setState(() => _country = v!),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // City
              _FieldLabel('City'),
              const SizedBox(height: 6),
              _FormField(
                controller: _cityCtrl,
                hint: 'Enter city',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              // Street
              _FieldLabel('Street Address'),
              const SizedBox(height: 6),
              _FormField(
                controller: _streetCtrl,
                hint: 'Enter street address',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              // Postal code
              _FieldLabel('Postal Code'),
              const SizedBox(height: 6),
              _FormField(
                controller: _postalCtrl,
                hint: 'Enter postal code',
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              // Apartment optional
              _FieldLabel('Apartment / Suite (optional)'),
              const SizedBox(height: 6),
              _FormField(
                controller: _aptCtrl,
                hint: 'Apt, suite, unit (optional)',
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CardReissueConfirmScreen(
                            country: _country,
                            city: _cityCtrl.text.trim(),
                            street: _streetCtrl.text.trim(),
                            postalCode: _postalCtrl.text.trim(),
                            apartment: _aptCtrl.text.trim(),
                          ),
                        ),
                      );
                    }
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
                    'CONTINUE',
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
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: const Color(0xFF858585),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(fontSize: 15, color: const Color(0xFF151515)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 15,
          color: const Color(0xFF858585),
        ),
        filled: true,
        fillColor: const Color(0xFFEBEFF2),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFFFBA08), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFFF536F), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFFF536F), width: 1.5),
        ),
      ),
    );
  }
}
