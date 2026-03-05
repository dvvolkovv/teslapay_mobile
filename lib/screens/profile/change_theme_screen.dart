import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeOption { light, dark, system }

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  AppThemeOption _selected = AppThemeOption.light;

  void _apply() {
    Navigator.of(context).pop(_selected);
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
              'Theme',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // Theme selection card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0F101828),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                  BoxShadow(
                    color: const Color(0x1A101828),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Light and Dark side by side
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ThemeCard(
                        label: 'Light',
                        icon: Icons.wb_sunny_outlined,
                        bgColor: const Color(0xFFF2F5F7),
                        isSelected: _selected == AppThemeOption.light,
                        onTap: () =>
                            setState(() => _selected = AppThemeOption.light),
                      ),
                      const SizedBox(width: 32),
                      _ThemeCard(
                        label: 'Dark',
                        icon: Icons.nightlight_round_outlined,
                        bgColor: const Color(0xFF202020),
                        isSelected: _selected == AppThemeOption.dark,
                        onTap: () =>
                            setState(() => _selected = AppThemeOption.dark),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(
                      height: 1, thickness: 1, color: Color(0xFFF2F5F7)),
                  const SizedBox(height: 8),

                  // System Default row with toggle
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Automatically',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF151515),
                            height: 1.2,
                          ),
                        ),
                      ),
                      _SystemToggle(
                        value: _selected == AppThemeOption.system,
                        onChanged: (v) {
                          setState(() {
                            _selected = v
                                ? AppThemeOption.system
                                : AppThemeOption.light;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Apply button
            GestureDetector(
              onTap: _apply,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBA08),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'APPLY',
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
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Phone preview
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 54,
            height: 99,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFFFBA08)
                    : const Color(0xFFF2F5F7),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: bgColor == const Color(0xFF202020)
                    ? Colors.white.withValues(alpha: 0.6)
                    : const Color(0xFF858585),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Radio dot
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? const Color(0xFFFFBA08)
                  : const Color(0xFFF2F5F7),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFFFBA08)
                    : const Color(0xFFF2F5F7),
                width: 1,
              ),
            ),
            child: isSelected
                ? const Center(
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),

          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF151515),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SystemToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SystemToggle({required this.value, required this.onChanged});

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
