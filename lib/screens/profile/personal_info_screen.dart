import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_name_screen.dart';
import 'change_birthday_screen.dart';
import 'change_address_screen.dart';
import 'change_email_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

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
          'Personal Information',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar row
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8E0D0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'AS',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3F4247),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Change photo',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF858585),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Info card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _InfoRow(
                  label: 'First Name',
                  value: 'Alexander',
                  editable: true,
                  onTap: () => Navigator.of(context).push(_route(
                    const ChangeNameScreen(),
                  )),
                ),
                _Divider(),
                _InfoRow(
                  label: 'Last Name',
                  value: 'Smith',
                  editable: true,
                  onTap: () => Navigator.of(context).push(_route(
                    const ChangeNameScreen(),
                  )),
                ),
                _Divider(),
                _InfoRow(
                  label: 'Date of Birth',
                  value: '15 March 1990',
                  editable: true,
                  onTap: () => Navigator.of(context).push(_route(
                    const ChangeBirthdayScreen(),
                  )),
                ),
                _Divider(),
                _InfoRow(
                  label: 'Phone',
                  value: '+7 912 345 6789',
                  editable: false,
                  onTap: null,
                ),
                _Divider(),
                _InfoRow(
                  label: 'Email',
                  value: 'alex@example.com',
                  editable: true,
                  onTap: () => Navigator.of(context).push(_route(
                    const ChangeEmailScreen(),
                  )),
                ),
                _Divider(),
                _InfoRow(
                  label: 'Address',
                  value: 'Moscow, Russia',
                  editable: true,
                  onTap: () => Navigator.of(context).push(_route(
                    const ChangeAddressScreen(),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PageRouteBuilder _route(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (ctx, a1, a2) => page,
      transitionsBuilder: (ctx, anim, a2, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Color(0xFFF2F5F7),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool editable;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.editable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: editable ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF858585),
                      letterSpacing: 0.25,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: editable
                          ? const Color(0xFF151515)
                          : const Color(0xFFA5B1BC),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            if (editable)
              const Icon(Icons.edit_outlined,
                  size: 18, color: Color(0xFFA5B1BC)),
          ],
        ),
      ),
    );
  }
}
