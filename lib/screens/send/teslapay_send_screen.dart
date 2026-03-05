import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teslapay_amount_screen.dart';

class _Contact {
  final String name;
  final String phone;
  const _Contact(this.name, this.phone);
}

const _kContacts = [
  _Contact('Anna K.', '+7 912 345 6789'),
  _Contact('Boris M.', '+49 176 123 456'),
  _Contact('Carol S.', '+1 555 234 567'),
];

class TeslapaySendScreen extends StatefulWidget {
  const TeslapaySendScreen({super.key});

  @override
  State<TeslapaySendScreen> createState() => _TeslapaySendScreenState();
}

class _TeslapaySendScreenState extends State<TeslapaySendScreen> {
  final _searchCtrl = TextEditingController();
  List<_Contact> _filtered = _kContacts;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = q.isEmpty
            ? _kContacts
            : _kContacts
                .where((c) =>
                    c.name.toLowerCase().contains(q) ||
                    c.phone.contains(q))
                .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'Send to TeslaPay',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Text(
                  '1/3',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF858585),
                  ),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Stack(
            children: [
              Container(height: 2, color: const Color(0xFFDEE5F2)),
              FractionallySizedBox(
                widthFactor: 1 / 3,
                child: Container(height: 2, color: const Color(0xFFFFBA08)),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter email, phone number\nor scan QR-code',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF151515),
              ),
            ),
            const SizedBox(height: 16),
            // Search field
            Container(
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF858585), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF151515),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Search by phone or name',
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
            ),
            const SizedBox(height: 24),
            Text(
              'Recent',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _filtered.length,
                  separatorBuilder: (_, i) => const Divider(
                    height: 1,
                    indent: 68,
                    endIndent: 16,
                    color: Color(0xFFDEE5F2),
                  ),
                  itemBuilder: (ctx, i) {
                    final contact = _filtered[i];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, a, b) =>
                                TeslapayAmountScreen(
                                  recipientName: contact.name,
                                  recipientPhone: contact.phone,
                                ),
                            transitionsBuilder: (_, anim, b, child) =>
                                SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                  parent: anim, curve: Curves.easeOut)),
                              child: child,
                            ),
                            transitionDuration:
                                const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFFFFBA08),
                        child: Text(
                          _initials(contact.name),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF151515),
                          ),
                        ),
                      ),
                      title: Text(
                        contact.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF151515),
                        ),
                      ),
                      subtitle: Text(
                        contact.phone,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF858585),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFFA5B1BC),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
