import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_widgets.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final _countryCtrl = TextEditingController(text: 'United Kingdom');
  final _cityCtrl = TextEditingController(text: 'London');
  final _streetCtrl = TextEditingController(text: 'Stratton');
  final _postalCtrl = TextEditingController(text: '54241');
  final _apartmentCtrl = TextEditingController(text: '8LT');

  @override
  void dispose() {
    _countryCtrl.dispose();
    _cityCtrl.dispose();
    _streetCtrl.dispose();
    _postalCtrl.dispose();
    _apartmentCtrl.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF151515), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add address',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            ProfileInputField(
              controller: _postalCtrl,
              label: 'Zip',
              hint: 'Postal code',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ProfileInputField(
              controller: _countryCtrl,
              label: 'Country',
              hint: 'Enter country',
            ),
            const SizedBox(height: 16),
            ProfileInputField(
              controller: _cityCtrl,
              label: 'City',
              hint: 'Enter city',
            ),
            const SizedBox(height: 16),
            ProfileInputField(
              controller: _streetCtrl,
              label: 'Street',
              hint: 'Enter street',
            ),
            const SizedBox(height: 16),
            ProfileInputField(
              controller: _apartmentCtrl,
              label: 'Apartment / Building',
              hint: 'Enter apartment',
            ),
            const Spacer(),
            ProfileSaveButton(onTap: _save),
          ],
        ),
      ),
    );
  }
}
