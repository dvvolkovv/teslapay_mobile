import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSettingsScreen extends StatefulWidget {
  const CardSettingsScreen({super.key});

  @override
  State<CardSettingsScreen> createState() => _CardSettingsScreenState();
}

class _CardSettingsScreenState extends State<CardSettingsScreen> {
  bool _onlinePayments = true;
  bool _contactlessPayments = true;
  bool _atmWithdrawals = false;
  bool _notifications = true;
  bool _offlineGeodata = true;

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
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded,
                color: Color(0xFF151515), size: 22),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Limits section — arrow items
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _ArrowTile(label: 'Spending limits', onTap: () {}),
                  const Divider(height: 1, indent: 16, endIndent: 16,
                      color: Color(0xFFF2F5F7)),
                  _ArrowTile(label: 'Withdrawal limits', onTap: () {}),
                  const Divider(height: 1, indent: 16, endIndent: 16,
                      color: Color(0xFFF2F5F7)),
                  _ArrowTile(label: 'Spending prioritization', onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Toggles
            _ToggleTile(
              label: 'Use online',
              value: _onlinePayments,
              onChanged: (v) => setState(() => _onlinePayments = v),
            ),
            const SizedBox(height: 8),
            _ToggleTile(
              label: 'Offline geodata tracking',
              value: _offlineGeodata,
              onChanged: (v) => setState(() => _offlineGeodata = v),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF858585),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF151515),
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: const Color(0xFFFFBA08),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFA5B1BC),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }
}

class _ArrowTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ArrowTile({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: const Color(0xFF151515),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF858585),
        size: 20,
      ),
    );
  }
}
