import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/countries.dart';
import 'otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasText = false;
  Country _selectedCountry = kCountries[0]; // Russia default

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _hasText = _controller.text.isNotEmpty);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_controller.text.isEmpty) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => OtpScreen(
            phone: '${_selectedCountry.code} ${_controller.text}'),
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Future<void> _openCountryPicker() async {
    _focusNode.unfocus();
    final result = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPickerSheet(selected: _selectedCountry),
    );
    if (result != null) {
      setState(() => _selectedCountry = result);
    }
    if (mounted) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _focusNode.requestFocus());
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final hasKeyboard = keyboardHeight > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.5)),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!hasKeyboard) const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/logo.svg',
                          width: 48,
                          height: 51,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFF0EFEC),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Login or Register\nto TeslaPay',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF0EFEC),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _PhoneInput(
                          controller: _controller,
                          focusNode: _focusNode,
                          country: _selectedCountry,
                          onCountryTap: _openCountryPicker,
                        ),
                        const SizedBox(height: 16),
                        _ContinueButton(
                          enabled: _hasText,
                          onTap: _onContinue,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                  if (!hasKeyboard) const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Country country;
  final VoidCallback onCountryTap;

  const _PhoneInput({
    required this.controller,
    required this.focusNode,
    required this.country,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFEBEFF2),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Country selector
          GestureDetector(
            onTap: onCountryTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(country.flag, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 2),
                const Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Color(0xFF151515)),
                const SizedBox(width: 6),
                Text(
                  country.code,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                    width: 1, height: 20, color: const Color(0xFFA5B1BC)),
                const SizedBox(width: 8),
              ],
            ),
          ),
          // Number input
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF151515),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone number',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF858585),
                ),
                isCollapsed: true,
              ),
              cursorColor: const Color(0xFFFFBA08),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  final Country selected;
  const _CountryPickerSheet({required this.selected});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<Country> _filtered = kCountries;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = q.isEmpty
            ? kCountries
            : kCountries
                .where((c) =>
                    c.name.toLowerCase().contains(q) || c.code.contains(q))
                .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFFF2F5F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFA5B1BC),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            'Select country',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF151515),
            ),
          ),
          const SizedBox(height: 12),
          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFFA5B1BC), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFF151515)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14, color: const Color(0xFFA5B1BC)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // List
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final c = _filtered[i];
                final isSelected = c.name == widget.selected.name;
                return ListTile(
                  onTap: () => Navigator.of(context).pop(c),
                  leading: Text(c.flag,
                      style: const TextStyle(fontSize: 24)),
                  title: Text(
                    c.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF151515),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    c.code,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: isSelected
                          ? const Color(0xFFFFBA08)
                          : const Color(0xFF858585),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;

  const _ContinueButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFFFFBA08),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'CONTINUE',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: enabled
                  ? const Color(0xFF151515)
                  : const Color(0xFFD68803),
              letterSpacing: 0.32,
            ),
          ),
        ),
      ),
    );
  }
}
