import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'personal_info_screen.dart';
import 'security_screen.dart';
import 'change_theme_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF151515), size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF151515),
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded,
                          color: Color(0xFF151515), size: 24),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.search_rounded,
                          color: Color(0xFF151515), size: 24),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Avatar + name + email
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Row(
                  children: [
                    // Avatar circle
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
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alexander Smith',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF151515),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'alex@example.com',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF858585),
                              letterSpacing: 0.25,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                '#123456',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF858585),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _KycBadge(status: 'Verified'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // PERSONAL INFORMATION section
            SliverToBoxAdapter(
              child: _SectionHeader('PERSONAL INFORMATION'),
            ),
            SliverToBoxAdapter(
              child: _MenuCard(
                items: [
                  _MenuItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Info',
                    onTap: () => Navigator.of(context).push(_route(
                      const PersonalInfoScreen(),
                    )),
                  ),
                  _MenuItem(
                    icon: Icons.badge_outlined,
                    title: 'Documents',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 4)),

            // ACCOUNT section
            SliverToBoxAdapter(
              child: _SectionHeader('ACCOUNT'),
            ),
            SliverToBoxAdapter(
              child: _MenuCard(
                items: [
                  _MenuItem(
                    icon: Icons.shield_outlined,
                    title: 'Security',
                    onTap: () => Navigator.of(context).push(_route(
                      const SecurityScreen(),
                    )),
                  ),
                  _MenuItem(
                    icon: Icons.credit_card_outlined,
                    title: 'Linked Cards',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 4)),

            // PREFERENCES section
            SliverToBoxAdapter(
              child: _SectionHeader('PREFERENCES'),
            ),
            SliverToBoxAdapter(
              child: _MenuCard(
                items: [
                  _MenuItem(
                    icon: Icons.palette_outlined,
                    title: 'App Theme',
                    onTap: () => Navigator.of(context).push(_route(
                      const ChangeThemeScreen(),
                    )),
                  ),
                  _MenuItem(
                    icon: Icons.language_rounded,
                    title: 'Language',
                    trailing: 'English',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.euro_rounded,
                    title: 'Currency',
                    trailing: 'EUR',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 4)),

            // SUPPORT section
            SliverToBoxAdapter(
              child: _SectionHeader('SUPPORT'),
            ),
            SliverToBoxAdapter(
              child: _MenuCard(
                items: [
                  _MenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.support_agent_rounded,
                    title: 'Contact Support',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms & Privacy',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Logout button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'LOG OUT',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF536F),
                          letterSpacing: 0.32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
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

class _KycBadge extends StatelessWidget {
  final String status;
  const _KycBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isVerified = status == 'Verified';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isVerified
            ? const Color(0xFF099A29).withValues(alpha: 0.12)
            : const Color(0xFFFFBA08).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isVerified
              ? const Color(0xFF099A29)
              : const Color(0xFFD68803),
          height: 1.2,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF858585),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });
}

class _MenuCard extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: items.map((item) {
            return ListTile(
              onTap: item.onTap,
              leading: Icon(item.icon, color: const Color(0xFF151515), size: 22),
              title: Text(
                item.title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color(0xFF151515),
                ),
              ),
              trailing: item.trailing != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.trailing!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF858585),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16, color: Color(0xFFA5B1BC)),
                      ],
                    )
                  : const Icon(Icons.arrow_forward_ios_rounded,
                      size: 16, color: Color(0xFFA5B1BC)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
