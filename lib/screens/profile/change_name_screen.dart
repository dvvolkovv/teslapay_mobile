import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_widgets.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  final _firstNameCtrl = TextEditingController(text: 'Alexander');
  final _lastNameCtrl = TextEditingController(text: 'Smith');

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
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
        title: Text(
          'Change Name',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Name',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            ProfileInputField(
              controller: _firstNameCtrl,
              label: 'First Name',
              hint: 'Enter first name',
            ),
            const SizedBox(height: 16),
            ProfileInputField(
              controller: _lastNameCtrl,
              label: 'Last Name',
              hint: 'Enter last name',
            ),
            const Spacer(),
            ProfileSaveButton(onTap: _save),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
