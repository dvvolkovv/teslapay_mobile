import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_password_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricEnabled = true;
  bool _twoFaEnabled = false;
  bool _accessWithoutAuth = false;

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
          'Security',
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
          // Main security options card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                _SecurityArrowTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  subtitle: 'Update your account password',
                  onTap: () => Navigator.of(context).push(_route(
                    const ChangePasswordScreen(),
                  )),
                ),
                _TileDivider(),
                _SecurityArrowTile(
                  icon: Icons.pin_outlined,
                  title: 'Reset Transaction PIN',
                  subtitle: 'Change your 5-digit PIN',
                  onTap: () {},
                ),
                _TileDivider(),
                _SecurityToggleTile(
                  icon: Icons.fingerprint_rounded,
                  title: 'Biometric Login',
                  subtitle: 'Use Face ID or fingerprint',
                  value: _biometricEnabled,
                  onChanged: (v) => setState(() => _biometricEnabled = v),
                ),
                _TileDivider(),
                _SecurityToggleTile(
                  icon: Icons.security_rounded,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Extra layer of security',
                  value: _twoFaEnabled,
                  onChanged: (v) => setState(() => _twoFaEnabled = v),
                ),
                _TileDivider(),
                _SecurityArrowTile(
                  icon: Icons.devices_outlined,
                  title: 'Active Sessions',
                  subtitle: 'Manage logged-in devices',
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Access without auth card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Access without authorization',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF151515),
                          height: 1.4,
                        ),
                      ),
                    ),
                    _YellowToggle(
                      value: _accessWithoutAuth,
                      onChanged: (v) =>
                          setState(() => _accessWithoutAuth = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'You can enter back the application within 5 minutes after unlocking',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF151515),
                    letterSpacing: 0.25,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Color(0xFFF2F5F7),
    );
  }
}

class _SecurityArrowTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SecurityArrowTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF151515), size: 22),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: const Color(0xFF151515),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF858585),
          letterSpacing: 0.25,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: Color(0xFFA5B1BC)),
    );
  }
}

class _SecurityToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SecurityToggleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF151515), size: 22),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: const Color(0xFF151515),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF858585),
          letterSpacing: 0.25,
        ),
      ),
      trailing: _YellowToggle(value: value, onChanged: onChanged),
    );
  }
}

class _YellowToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _YellowToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 20,
        decoration: BoxDecoration(
          color: value ? const Color(0xFFFFBA08) : const Color(0xFFF2F5F7),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(2),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
